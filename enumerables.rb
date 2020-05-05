module Enumerable

  def my_each
    i = 0
    arr = self
    if block_given?
      while i < arr.count
        yield(arr[i])
        i += 1
      end
    else
      arr.to_enum
    end
  end

  def my_each_with_index
    i = 0
    arr = self
    if block_given?
      while i < arr.count
        yield(arr[i], i)
        i += 1
      end
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
        my_each { |obj| to_change = true if arr.include?(true) || obj != false }
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

  def my_none?
    i = 0
    to_change = true
    arr = self
    while i < arr.count
      to_change = false if yield(arr[i])
      i += 1
    end
    to_change
  end

  def my_map(the_proc)
    i = 0
    to_change = []
    arr = self
    arg = the_proc.nil?
    while i < arr.count
      to_change << (the_proc.call arr[i]) unless arg == true
      to_change << yield(arr[i]) if arg == true
      i += 1
    end
    to_change
  end

  def my_count
    arr = self
    i = 0
    total = 0
    while i < arr.count
      arr.my_each { total += 1 }
      i += 1
    end
    total
  end

  def my_inject(start_value = 0, operator = nil)
    i = 0
    arr = self
    to_change = 0
    to_change = 1 if operator == :*
    to_change = 1 if operator == :/
    to_change = start_value if start_value != 0
    if operator.is_a? Symbol
      while i < arr.count
        case operator
        when :+
          to_change += arr[i]
        when :-
          to_change -= arr[i]
        when :*
          to_change *= arr[i]
        when :/
          to_change /= arr[i]
        end
        i += 1
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
