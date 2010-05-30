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

    context "and create_childeren called" do 
      setup do
        @data = { :a => 1, :b => 2 }
        @child_instances = Konfig::Adapter.create_child_instances(@data)
      end

      should "create 2 instances" do
        assert_equal 2, @child_instances.size
      end

      should "make instances available through accessor" do
        assert_equal @child_instances, Konfig::Adapter.child_instances
      end

      should "create the correct instances" do
        assert @child_instances[0].is_a?(FirstAdapter)
        assert @child_instances[1].is_a?(SecondAdapter)
      end

      should "assign the correct data to child instances" do
        assert_equal @data, @child_instances[0].data
        assert_equal @data, @child_instances[1].data
      end

      should "be able to send method calls to chld instances" do
        r = []
        Konfig::Adapter.send_to_child_instances(:instance_append, r)
        assert_equal [9, 8], r
      end

    end

  end

end

