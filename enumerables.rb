module Enumerable
    def my_each 
        i = 0
        while i < self.count
            yield(self[i])
            i = i + 1
        end
    end

    def my_each_with_index
        i = 0
        while index < self.count
            yield(self[i], i)
            i = i + 1
        end
    end

    def my_select
        i = 0
        to_change = []
        while i < self.count
            to_change << self[i] if yield(self[i])
            i = i + 1
        end
        to_change
    end

    def my_any?
        i = 0
        to_change = false
        while i < self.count
            to_change = true if yield(self[i])
            i = i + 1
        end
        to_change
    end

    def my_all?
        i = 0
        to_change = true
        while i < self.count
            to_change = false unless yield(self[i])
            i = i + 1
        end
        to_change
    end

    def my_none?
        i = 0
        to_change = true
        while i < self.count
            to_change = false if yield(self[i])
            i = i + 1
        end
        to_change
    end

    def my_map(the_proc=nil)
        i = 0
        to_change = []
        while i < self.count
            unless the_proc == nil
            to_change << (the_proc.call self[i])
            else
            to_change << yield(self[i])
        end
        to_change
    end
  end
    def my_inject fr_value
        i = 0
        while i < self.count
            fr_value = yield(fr_value,self[i])  
            i = i + 1
        end
        fr_value
    end

    def multiply_els
        self.my_inject (1) { |result, obj| result * obj}
    end
    [2,4,5].multiply_els
end
