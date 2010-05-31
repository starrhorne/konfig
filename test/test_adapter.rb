require 'helper'

class TestEvaluator < Test::Unit::TestCase

  context "Adapter with two subclasses" do

    Konfig::Adapter.clear_child_classes

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
      assert_equal 2, Konfig::Adapter.child_classes.size
    end

    should "have the correct subclasses in registry" do
      assert_equal FirstAdapter, Konfig::Adapter.child_classes[0]
      assert_equal SecondAdapter, Konfig::Adapter.child_classes[1]
    end

    should "not have bleed over to child classes" do
      assert_equal 0, FirstAdapter.child_classes.size
      assert_equal 0, SecondAdapter.child_classes.size
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

  context "User adapter with 3 templates" do

    setup do

      class TemplateAdapter < Konfig::Adapter
        has_template :inline, :content => "inline"
        has_template :file, :file => "./test/fixtures/template.yml"
        has_template :block do
          "block"
        end
      end

    end

    should "register 3 templates" do
      assert_equal 3, Konfig::Adapter.templates.size
    end

    should "return correct value for inline template" do
      assert_equal "inline", Konfig::Adapter.templates[:inline]
    end

    should "return correct value for file template" do
      assert_equal File.read("./test/fixtures/template.yml"), Konfig::Adapter.templates[:file]
    end

    should "return correct value for block template" do
      assert_equal "block", Konfig::Adapter.templates[:block]
    end

  end

end

