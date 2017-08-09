require 'reform'
require 'active_support/concern'

#
module ActiveAdmin
  #
  module Reform
    #
    module ResourceController
      # Overrides ActiveAdmin' templates method to wrap model into Reform::Form
      module DataAccess
        extend ActiveSupport::Concern

        # @param _resource [ActiveRecord::Base]
        # @return [ActiveRecord::Base, Reform::Form]
        def apply_decorations(_resource)
          apply_form(super)
        end

        def create_resource(object)
          run_create_callbacks object do
            if resource.is_a?(::Reform::Form)
              unless object.errors.any?
                create_command.run!(resource: object.model, data: object.to_nested_hash.with_indifferent_access)
              end
            else
              super
            end
          end
        end

        def update_resource(object, attributes)
          object.validate(attributes.first)

          run_update_callbacks object do
            if object.is_a?(::Reform::Form)
              unless object.errors.any?
                update_command.run!(resource: object.model, data: object.to_nested_hash.with_indifferent_access)
              end
            else
              super
            end
          end
        end

        def save_resource(object)
          if resource.is_a?(::Reform::Form)
            super unless object.errors.any?
          else
            super
          end
        end
      end

      ::ActiveAdmin::ResourceController.send(:include, DataAccess)
    end
  end
end
