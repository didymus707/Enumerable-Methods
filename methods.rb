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
    
    def my_select
        arr = []
    end

end

# [1,2,3].my_each { |x| puts x * 5}
# [1,2,3].my_each_with_index { |x, y| puts "index position #{y}" }
[1,2,3,4,5].my_select { |num|  num.even?  }   
