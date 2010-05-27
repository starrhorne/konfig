require 'helper'
require 'yaml'

class TestKonfig < Test::Unit::TestCase

  context "no store loaded" do

    should "raise an exception on access" do
      assert_raises(RuntimeError) { Konfig[:some_key] }
    end

  end

  context "store loaded" do

    setup do
      Konfig.load_directory("./test/fixtures")
    end

    should "load all files" do
      assert Konfig[:static]
      assert Konfig[:dynamic]
    end

  end

end
