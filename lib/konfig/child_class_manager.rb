module Konfig

  # Provides tools for keeping track of a Class's descendents
  
  module ChildClassManager

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      # Should not be called directly.
      def inherited(child_class)
        child_classes << child_class
      end

      # Get all child classes
      # @return [Array] an array of child classes
      def child_classes
        @child_classes ||= []
      end

      # Remove child classes from registry
      def clear_child_classes
        @child_classes = []
      end

      # Instanciates all child classes
      # @return [Array] Instances of all child classes
      def create_child_instances(*params)
        @child_instances = child_classes.map { |c| c.new(*params) }
      end

      # Invoke 'send' on all child instances
      # @param params Parameters for 'send'
      def send_to_child_instances(*params)
        @child_instances.each { |c| c.send(*params) }
      end

      # Instanciates all child classes
      # @return [Array] Instances of all child classes
      def child_instances
        @child_instances || []
      end

    end

  end

end
