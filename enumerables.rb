# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
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
    if !block_given?
      if arg.nil?
        my_each { |obj| to_change = true unless obj == false || obj.nil? }
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
    return arr.to_enum unless block_given?

    to_change = []
    my_each do |obj|
      to_change.push(yield obj)
    end
    to_change
  end

  def my_count(arg = nil)
    arr = self
    total = 0
    if arg.nil?
      if block_given?
        my_each do |item|
          total += 1 if yield(item)
        end
      else
        total = arr.length
      end
    else
      my_each { |obj| total += 1 if obj == arg }
    end
    total
  end

  def my_inject(num = 0, oper = nil)
    to_change = dup if respond_to?(:to_a)
    to_change = to_a.dup if is_a?(Range)

    if num.is_a?(Symbol)
      oper = num
      num = 0
    end

    if oper.is_a?(Symbol)
      case oper
      when :+
        num = to_change.my_inject(num) { |acum, obj| acum + obj }
      when :-
        num = to_change.my_inject(num) { |acum, obj| acum - obj }
      when :*
        num = to_change.my_inject(num) { |acum, obj| acum * obj }
      when :/
        num = to_change.my_inject(num) { |acum, obj| acum / obj }
      else
        puts 'Invalid operator'
      end
    else
      if num.zero?
        num = to_change[0]
        to_change.shift
      end
      to_change.my_each do |obj|
        num = yield num, obj
      end
    end
    num
  end
end

def multiply_els(array)
  array.my_inject(:*)
end
p multiply_els([1, 2, 3])
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
