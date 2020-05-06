module Enumerable
  def my_each
    i = 0
    arr = self
    if block_given?
      if arr.respond_to?(:to_a)
        core = arr.to_a
        while i < core.count
          yield(core[i])
          i += 1
        end
        arr
      else
        while i < arr.count
          yield(arr[i])
          i += 1
        end
      end
    else
      arr.to_enum
    end
  end

  def my_each_with_index
    i = -1
    arr = self
    if block_given?
      arr.my_each { |obj| yield(obj, i += 1) }
    else
      arr.to_enum
    end
  end

  def my_select
    i = 0
    to_change = []
    arr = self
    if block_given?
      while i < arr.count
        to_change << arr[i] if yield(arr[i])
        i += 1
      end
      to_change
    else
      arr.to_enum
    end
  end

  def my_any?(arg = nil)
    to_change = false
    arr = self
    if !block_given?
      if arg.nil?
        my_each { |obj| to_change = true unless obj == false   || obj.nil?}
      elsif arg.respond_to?(:to_i)
        my_each { |obj| to_change = true if obj == arg }
      elsif arg.is_a?(Regexp)
        my_each { |obj| to_change = true if obj.match(arg) }
      elsif arg.respond_to?(:class)
        my_each { |obj| to_change = true if obj.instance_of? arg }
      end
    else
      my_each { |obj| to_change = true if yield obj }
    end
    to_change
  end

  def my_all?(arg = nil)
    to_change = true
    arr = self
    if !block_given?
      if arg.nil?
        my_each { |obj| to_change = false unless arr.include?(true) || obj != false }
      elsif arg.respond_to?(:to_i)
        my_each { |obj| to_change = false unless obj == arg }
      elsif arg.is_a?(Regexp)
        my_each { |obj| to_change = false unless obj.match(arg) }
      elsif arg.respond_to?(:class)
        my_each { |obj| to_change = false unless obj.instance_of? arg }
      end
    else
      my_each { |obj| to_change = false unless yield obj }
    end
    to_change
  end

  def my_none?(arg = nil)
    to_change = true
    arr = self
    if !block_given?
      if arg.nil?
        my_each { |obj| to_change = false if arr.include?(true) || obj == true }
      elsif arg.respond_to?(:to_i)
        my_each { |obj| to_change = false if obj == arg }
      elsif arg.is_a?(Regexp)
        my_each { |obj| to_change = false if obj.match(arg) }
      elsif arg.respond_to?(:class)
        my_each { |obj| to_change = false if obj.instance_of? arg }
      end
    else
      my_each { |obj| to_change = false if yield obj }
    end
    to_change
  end

  def my_map
    arr = self
    if block_given?
      to_change = []
      my_each do |obj|
        to_change.push(yield obj)
      end
    else
      arr.to_enum
    end
    to_change
  end

  def my_count(arg = nil)
    arr = self
    total = 0
    if arg.nil?
      if block_given?
        my_each do |item|
          total +=1 if yield(item)
        end
      else
      total = arr.length
      end
    else
      my_each { |obj| total += 1 if obj == arg }
    end
    total
  end

  def my_inject(start_value = 0, operator = nil)
    arr = self
    to_change = 0
    to_change = 1 if operator == :*
    to_change = 1 if operator == :/
    to_change = start_value if start_value != 0
    operator = start_value if start_value.is_a? Symbol
    if operator.is_a? Symbol
        case operator
        when :+
          arr.each { |obj| to_change += obj}
        when :-
          arr.each { |obj| to_change -= obj}
        when :*
          arr.each { |obj| to_change *= obj}
        when :/
          arr.each { |obj| to_change /= obj}
        end
    end
    if block_given?
      my_each do |obj|
        to_change = yield to_change, obj
      end
    end
    to_change
  end
end

def multiply_els(value = 1)
  arr = self
  arr.my_inject(value, :*)
end
[2, 4, 5].multiply_els
