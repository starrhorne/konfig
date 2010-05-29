require 'helper'

class TestEvaluator < Test::Unit::TestCase

  Konfig::Adapter.clear_children

  context "Adapter with two subclasses" do

    setup do

      class FirstAdapter < Konfig::Adapter

        def instance_append(value)
          value << 9
        end

        def self.append(value)
          value << 2
        end
      end

      class SecondAdapter < Konfig::Adapter

        def instance_append(value)
          value << 8
        end

        def self.append(value)
          value << 4
        end
      end
    end

    should "have two registered subclasses" do
      assert_equal 2, Konfig::Adapter.children.size
    end

    should "have the correct subclasses in registry" do
      assert_equal FirstAdapter, Konfig::Adapter.children[0]
      assert_equal SecondAdapter, Konfig::Adapter.children[1]
    end

    should "not have bleed over to child classes" do
      assert_equal 0, FirstAdapter.children.size
      assert_equal 0, SecondAdapter.children.size
    end

    should "be able to send method calls to children" do
      values = []
      Konfig::Adapter.send_to_children(:append, values)
      assert_equal [2, 4], values
    end

    should "be able to instanciate all children, and send" do
      values = []
      Konfig::Adapter.create_and_send_to_children(:instance_append, values)
      assert_equal [9, 8], values
    end

  end

end

