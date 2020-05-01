
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
      arr
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
      arr
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
      arr
    end
  end

  def my_any?(arg = nil)
    arr = self
    i = 0
    to_change = false
    while i < arr.count
      if !block_given?
          to_change = true if include?(true) && arg.nil?
          to_change = true if arr[i] == arg && arg.respond_to?(:to_i)
          to_change = true if arr[i].match(arg) && arg.is_a?(Regexp)
          to_change = true if arr[i].instance_of?(arg) && arg.respond_to?(:class)
        end
      else
        to_change = false unless yield(arr[i])
      end
      i += 1
    end
    to_change
  end

  def my_all?
    i = 0
    to_change = true
    arr = self
    while i < arr.count
      to_change = false unless yield(arr[i])
      i += 1
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
    total = 0
    self.my_each{total += 1}
    total
  end

  def my_inject (start_value = 0, operator)
    i = 0
    arr = self
    to_change = 0
    to_change = 1 if operator == :* || operator == :/
    to_change = start_value if start_value != 0
    if operator.is_a? (Symbol)
      while i < arr.count
        if operator == :+
          to_change += arr[i]
        elsif operator == :-
          to_change -= arr[i]
        elsif operator == :*
          to_change *= arr[i]
        elsif operator == :/
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

