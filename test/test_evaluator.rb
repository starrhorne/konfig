require 'helper'

class TestEvaluator < Test::Unit::TestCase

  context "an evaluator with simple data" do
    setup do
      @data = { :a => 1, :b => 2 }
      @evaluator = Konfig::Evaluator.new(@data)
    end

    should "evaluate" do
      assert_equal 4, @evaluator.run("2+2")
    end

    should "have access to data" do
      assert_equal @data[:a], @evaluator.run("data[:a]")
    end

  end

  context "names_by_value helper" do
    setup do
      @data = { :options => [["name", "val"], ["name2", "val2"]] }
      @evaluator = Konfig::Evaluator.new(@data)
    end

    should "work when given key" do
      assert_equal({"val" => "name", "val2" => "name2"}, @evaluator.run("names_by_value(:options)"))
    end

    should "work when given an array" do
      assert_equal({"val" => "name", "val2" => "name2"}, @evaluator.run("names_by_value(data[:options])"))
    end

  end

end
