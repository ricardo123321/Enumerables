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

end