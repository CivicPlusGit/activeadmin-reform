require 'active_support/concern'

#
module ActiveAdmin
  #
  module Reform
    # Defines form class accessor
    module Resource
      extend ActiveSupport::Concern

      included do
        attr_accessor :create_form_class_name
        attr_accessor :update_form_class_name
        attr_accessor :create_command_name
        attr_accessor :update_command_name
        attr_accessor :delete_command_name
      end

      # @return [nil, Class<Reform::Form>]
      def create_form_class
        ActiveSupport::Dependencies.constantize(create_form_class_name) if create_form_class_name
      end

      def update_form_class
        ActiveSupport::Dependencies.constantize(update_form_class_name) if update_form_class_name
      end

      def create_command
        ActiveSupport::Dependencies.constantize(create_command_name) if create_command_name
      end

      def update_command
        ActiveSupport::Dependencies.constantize(update_command_name) if update_command_name
      end
    end

    ::ActiveAdmin::Resource.send(:include, Resource)
  end
end
