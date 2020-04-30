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

  def my_any?
    i = 0
    to_change = false
    arr = self
    if block_given?
      while i < arr.count
        to_change = true if yield(arr[i])
        i += 1
      end
      to_change
    else
      arr
    end
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

  def my_inject(fr_value)
    i = 0
    arr = self
    while i < arr.count
      fr_value = yield(fr_value, arr[i])
      i += 1
    end
    fr_value
  end

  def multiply_els
    arr = self
    arr.my_inject(1) { |result, obj| result * obj }
  end
  [2, 4, 5].multiply_els
end
