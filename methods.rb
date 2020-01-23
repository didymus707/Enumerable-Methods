module Enumerable
    def my_each
        for i in (0..self.length-1)
            yield self[i]
        end
    end

    def my_each_with_index
        for i in (0..self.length-1)
            yield self[i], i
        end
    end
end
  
