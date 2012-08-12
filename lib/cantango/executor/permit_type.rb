# This class is responsible for executing a set of similar Permits and collecting their rule results into one rule collection
# which can be cached under some key and later reused
#
module CanTango
  module Executor
    class PermitType < Base
      attr_reader :ability, :permit_type, :permits

      def initialize ability, permit_type, permits
        @ability      = ability
        @permit_type  = permit_type
        @permits      = permits
      end

      def execute!
        # TODO: somehow type specific caching of result of permits!
        permits.each do |permit|
          CanTango.config.permits.was_executed(permit, ability) if CanTango.debug?
          break if permit.execute == :break
        end
      end

      protected

      def valid?
        true
      end

      def start_execute
        debug "Execute #{permit_type} permits"
      end

      def end_execute
        debug "Done #{permit_type} permits"
      end

      def key_method_names
        permit_class = CanTango.config.permits.available_permits[permit_type]
        key = permit_class.hash_key if permit_class && permit_class.respond_to?(:hash_key)
        key ? [key] : []
      end
    end
  end
end
