module Enumerable
    def my_each 
        index = 0
        while index < self.count
            yield(self[index])
            index += 1
        end
    end


