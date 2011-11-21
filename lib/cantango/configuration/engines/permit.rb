module CanTango
  class Configuration
    class Engines
      class PermitEngineConfig < EngineConfig
        def on?
          @state ||= :on
          @state == :on
        end

        def types
          [:roles, :role_groups, :licenses, :users]
        end

        def special_permits
          [:any, :system]
        end
        
        protected
        
        def valid_mode_names
          [:cache, :no_cache, :both]
        end
      end
    end
  end
end

