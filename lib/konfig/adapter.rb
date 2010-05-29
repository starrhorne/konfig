
module Konfig

  # All adapters are subclassed from Konfig::Adapter
  class Adapter

    class << self

      def inherited(child_class)
        children << child_class
      end

      # Get all child classes
      # @return [Array] an array of child classes
      def children
        @children ||= []
      end

      # Remove child classes from registry
      def clear_children
        @children = []
      end

      # Evokes the send method on all child classes, 
      # and passes the args along
      def send_to_children(*args)
        children.each { |c| c.send(*args) }
      end

      # Instanciates all child classes and envokes
      # a method via obj.send
      def create_and_send_to_children(*args)
        children.each { |c| c.new.send(*args) }
      end


    end
  end
end
