# The Hash2Obj gem for Ruby

[![Gem Version](https://badge.fury.io/rb/hash2obj.svg)](https://badge.fury.io/rb/hash2obj)
[![Build Status](https://travis-ci.org/hex0cter/hash2obj.svg?branch=master)](https://travis-ci.org/hex0cter/hash2obj)

Hash2Obj is a ruby gem that converts a hash into a Ruby object.

During the web development, it is common to transfer json between the browser and the server. When the json from the
browser presents an object, you might need to convert it back into a Ruby object on the server side.

Normally the class you want to convert to has to provide a method or constructor that takes a hash as argument. In that
way you will have to implement the same interface for all the classes.

Hash2Obj provides another solution for this. When you want to convert a json (hash) into the object, you just need to
provide an existing instance of the same class. For example,

When you call

```ruby
Hash2Obj.cast(hash, object)
```

hash2obj will first inspect all the internal data of object and find out which are writable (for instance,
attr_accessor, attr_writer, etc.) and which are not (for instance, attr_reader, private members, etc).

For those that are not writable, hash2obj attempts to call its constructor using the information provided by the hash.
At the moment hash2obj supports the class constructor in any of the following forms:

```ruby
class A
    def initialize([param_1[, param_2[, ...]]] [param_x:[, param_y:[, ...]]] [**args])
        ...
    end
end
```

Once a new instance is created, hash2obj just copies all the other accessible data to the new instance.

Below is an example of how to use hash2obj:

```ruby
require 'hash2obj'

module TestModule
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


old_obj = TestModule::MyKlass.new(1, b3: 3, b5:5)
old_obj.b6 = 6
old_obj.inspect # => "#<MyModule::MyKlass:0x007fb402851750 @b1=1, @b2=2, @b3=3, @b4=4, @b5=5, @b6=6>"

new_obj = Hash2Obj.cast({b1: 11, b2: 12, b3: 13, b4: 14, b5: 15, b6: 16}, old_obj)
new_obj.inspect # => "#<MyModule::MyKlass:0x007fb40225b580 @b1=11, @b2=12, @b3=13, @b4=14, @b5=15, @b6=16>"
```

## How to install?

From a terminal run

```bash
  gem install hash2obj
```

or add the following code into your Gemfiles:

```ruby
  gem 'hash2obj'
```

## License

This code is free to use under the terms of the MIT license.

## Contribution

You are more than welcome to raise any issues [here](https://github.com/hex0cter/hash2obj/issues), or create a Pull Request.
