require_relative 'paths'
require 'hash2obj'
require 'minitest/autorun'

module MyModule
  class MyKlass
    attr_reader :b1
    attr_reader :b2
    attr_reader :b3
    attr_reader :b4
    attr_writer :b5
    attr_writer :b6

    def initialize(b1, b2 = 2, b3:, b4: 4, **args)
      @b1 = b1
      @b2 = b2
      @b3 = b3
      @b4 = b4
      @b5 = args.fetch :b5, 0
      @b6 = args.fetch :b6, 0
    end

    def get_attr_b5
      @b5
    end

    def get_attr_b6
      @b6
    end
  end
end

class TestMixedParams < Minitest::Test
  def test_plain_attrs
    obj_b = MyModule::MyKlass.new(1, b3: 3, b5:5)
    obj_b.b6 = 6
    obj_b.inspect

    avatar = Hash2obj.cast({b1: 11, b2: 12, b3: 13, b4: 14, b5: 15, b6: 16}, obj_b)
    avatar.inspect
    assert avatar.b1 == 11
    assert avatar.b2 == 12
    assert avatar.b3 == 13
    assert avatar.b4 == 14
    assert avatar.get_attr_b5 == 15
    assert avatar.get_attr_b6 == 16
  end
end

