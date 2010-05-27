require 'helper'
require 'yaml'

class TestStore < Test::Unit::TestCase

  context "an empty store" do

    setup do
      @store = Konfig::Store.new
    end

    should "return nil from store[key]" do
      assert_nil @store[:some_key]
    end

    should "return an empty string on inspect" do
      assert_equal "{}", @store.inspect
    end

    context "with static.yml file loaded" do 

      setup do
        @store.load_file("./test/fixtures/static.yml")
        @static = YAML.load_file("./test/fixtures/static.yml")
      end

      should "have key named static" do
        assert @store[:static]
      end

      should "have correct_values" do
        assert_equal @static, @store[:static]
      end

    end

    context "with dynamic.yml file loaded" do 

      setup do
        @store.load_file("./test/fixtures/dynamic.yml")
      end

      should "evaluate code" do
        assert_equal 2, @store[:dynamic][:one_plus_one]
      end

      should "be able to reference itself" do
        assert_equal 5, @store[:dynamic][:five]
        assert_equal 6, @store[:dynamic][:six]
        assert_equal 5*6, @store[:dynamic][:five_times_six]
      end

      should "be able to reference nested attributes" do
        assert_equal 5, @store[:dynamic][:parent][:child]
        assert_equal 5+1, @store[:dynamic][:parent][:child_plus_one]
      end

    end

    context "with directory loaded" do 
      setup do
        @store.load_directory("./test/fixtures")
      end

      should "load all files" do
        assert @store[:static]
        assert @store[:dynamic]
      end

    end

  end


end
