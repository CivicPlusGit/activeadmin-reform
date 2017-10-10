require 'active_support/concern'
require_relative 'resource'

#
module ActiveAdmin
  #
  module Reform
    # Provide ActiveAdmin DSL for defining form class
    module Dsl
      extend ActiveSupport::Concern

      # Set form class for ActiveAdmin resource
      # @param form_class [Class, String]
      # @example
      #   ActiveAdmin.resource Author do
      #     form_class AuthorForm
      #     # You can disable form:
      #     form_class false
      #   end
      #
      def create_command(command_name)
        config.create_command_name = command_name ? "::#{command_name}" : nil
      end

      def update_command(command_name)
        config.update_command_name = command_name ? "::#{command_name}" : nil
      end

      def create_form_class(form_class)
        config.create_form_class_name = form_class ? "::#{form_class}" : nil
      end

      def update_form_class(form_class)
        config.update_form_class_name = form_class ? "::#{form_class}" : nil
      end
    end

    ::ActiveAdmin::ResourceDSL.send(:include, Dsl)
  end
end
