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
            self[i]{|obj| to_change << obj if yield(obj)}
            i++
            to_change
        end
    end