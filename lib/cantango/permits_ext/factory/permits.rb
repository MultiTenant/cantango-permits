module CanTango
  module Factory
    class Permits
      include CanTango::Helpers::Debug

      attr_accessor :ability

      # creates the factory for the ability
      # note that the ability contains the roles and role groups of the user (or account)
      # @param [Permits::Ability] the ability
      def initialize ability
        @ability = ability
      end

      def build!
        debug "Factory::Permits: No permits could be built" if permits.empty?
        permits
      end

      # return hash of permits built, keyed by name of builder
      def permits
        @permits ||= enabled_permit_types.inject({}) do |permits, permit_type|
          built_permits = permits_of(permit_type)
          permits[permit_type] = built_permits if built_permits
          permits
        end
      end

      def permits_of permit_type
        create_builder(permit_type).build
      end

      def create_builder permit_type
        clazz = builder_class permit_type
        clazz.constantize.new ability
      end

      def builder_class permit_type
        return "CanTango::Builder::Permit::Special" if permit_type == :special
        "CanTango::Builder::Permit::#{permit_type.to_s.camelize}"
      end

      def enabled_permit_types
        CanTango.config.permits.enabled_types
      end

      def options
        ability.options
      end
    end
  end
end