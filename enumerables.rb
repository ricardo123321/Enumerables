module Enumerable
    def my_each 
        i = 0
        while index < self.count
            yield(self[i])
            i = i + 1
        end
    end


