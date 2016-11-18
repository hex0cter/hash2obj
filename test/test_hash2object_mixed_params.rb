require_relative 'paths'
require 'hash2obj'
require 'minitest/autorun'

module MyModule
  class MyKlass
    attr_reader :b1
    attr_reader :b2
    attr_reader :b3
    attr_reader :b4
    attr_reader :b5
    attr_writer :b6

    def initialize(b1, b2 = 2, b3:, b4: 4, **args)
      @b1 = b1
      @b2 = b2
      @b3 = b3
      @b4 = b4
      @b5 = args.fetch :b5, 0
      @b6 = args.fetch :b6, 0
    end

    def get_attr_b6
      @b6
    end
  end
end

class TestMixedParams < Minitest::Test
  def setup
    @old_obj = MyModule::MyKlass.new(1, b3: 3, b5:5)
    @old_obj.b6 = 6
  end

  def test_plain_attrs
    new_obj = Hash2obj.cast({b1: 11, b2: 12, b3: 13, b4: 14, b5: 15, b6: 16}, @old_obj)
    assert new_obj.b1 == 11
    assert new_obj.b2 == 12
    assert new_obj.b3 == 13
    assert new_obj.b4 == 14
    assert new_obj.b5 == 15
    assert new_obj.get_attr_b6 == 16
  end

  def test_missing_attrs
    assert @old_obj.b1 == 1
    assert @old_obj.b5 == 5

    new_obj = Hash2obj.cast({b2: 12, b3: 13, b4: 14}, @old_obj)
    assert new_obj.b1 == 1
    assert new_obj.b2 == 12
    assert new_obj.b3 == 13
    assert new_obj.b4 == 14
    assert new_obj.b5 == 5
  end
end

