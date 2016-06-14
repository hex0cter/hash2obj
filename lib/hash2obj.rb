require 'ostruct'

# Hash2obj module
module Hash2obj
  def self.cast(hash, example)
    klass = example.class
    accessible_attr = []
    example.instance_variables.each do |attr|
      attr = attr.to_s.sub('@', '').to_sym
      if example.respond_to? ("#{attr}=")
        accessible_attr << attr
      end
    end

    key_args = {}
    args = []
    construct_params = example.method(:initialize).parameters
    construct_params.each do |param|
      arg_required, arg_name = param

      case arg_required
        when :req
          args << arg_name
        when :opt
          args << arg_name if hash.key? arg_name
        when :keyreq
          raise "parameter #{arg_name} is mandatory but missing in #{hash}" unless hash.key? arg_name
          key_args[arg_name] = hash[arg_name]
        when :keyrest
          key_args.merge! hash
          break
      end
    end

    args.map! { |val| hash[val] }
    if args.empty? and key_args.empty?
      instance = klass.send(:new)
    elsif args.empty?
      instance = klass.send(:new, key_args)
    elsif key_args.empty?
      instance = klass.send(:new, *args)
    else
      instance = klass.send(:new, *args, **key_args)
    end

    accessible_attr.each do |attr|
      instance.send("#{attr}=", hash[attr])
    end

    instance
  end
end
