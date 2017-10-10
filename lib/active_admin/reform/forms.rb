require 'active_support/concern'
require_relative 'resource_controller/data_access'

#
module ActiveAdmin
  #
  module Reform
    # Reform integration helpers
    module Forms
      extend ActiveSupport::Concern

      protected

      # Wrap resource into Reform::Form if needed
      # @param resource [ActiveRecord::Base]
      # @return [ActiveRecord::Base, Reform::Form]
      def apply_form(resource)
        if apply_form?
          form = form_class.new(resource)
          form.prepopulate! if prepopulate_form?
          form
        else
          resource
        end
      end

      private

      def prepopulate_form?
        %w(new edit).include?(action_name)
      end

      def form_class
        case action_name
        when 'new', 'create'
          create_form_class
        when 'edit', 'update'
          update_form_class
        end
      end

      def apply_form?
        case action_name
        when 'new', 'create'
          create_form_class.present?
        when 'edit', 'update'
          update_form_class.present?
        end
      end

      def create_form_class
        active_admin_config.create_form_class
      end

      def update_form_class
        active_admin_config.update_form_class
      end

      def create_command
        active_admin_config.create_command
      end

      def update_command
        active_admin_config.update_command
      end
    end

    ::ActiveAdmin::ResourceController.send(:include, Forms)
  end
end
