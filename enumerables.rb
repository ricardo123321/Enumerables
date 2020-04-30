module Enumerable
  def my_each
    i = 0
    arr = self
    while i < arr.count
      yield(arr[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    arr = self
    while index < arr.count
      yield(arr[i], i)
      i += 1
    end
  end

  def my_select
    i = 0
    to_change = []
    arr = self
    while i < arr.count
      to_change << arr[i] if yield(arr[i])
      i += 1
    end
    to_change
  end

  def my_any?
    i = 0
    to_change = false
    arr = self
    while i < arr.count
      to_change = true if yield(arr[i])
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

  def my_map(the_proc = nil)
    i = 0
    to_change = []
    arr = self
    while i < arr.count
      if the_proc.nil? && true
        to_change << yield(arr[i])
      else
        to_change << (the_proc.call arr[i])
      end
      i += 1
    end
    to_change
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
