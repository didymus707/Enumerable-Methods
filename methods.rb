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
        self.my_each do |x|
            arr << x if yield x
        end
        return arr
    end

    def my_all?
        result = true
        if block_given?
            self.my_each do |x|
                result = false if !yield(x)
            end
        else
            for i in self
                result = true if !i
            end
        end
        return result
    end

    def my_any?
        result = false
        if block_given?
            self.my_each do |x|
                result = true if yield(x)
            end
        else
            for i in self
                result = true if i
            end
        end
        return result
    end

    def my_none?
        result = false
        if block_given?
            self.my_each do |x|
                result = true if !yield(x)
            end
        else
            for i in self
                result = true if !i
            end
        end
        return result
    end

    def my_count(*args)
        count = 0
        if block_given?
            self.my_each { |x| count += 1 if yield(x) }
        elsif args.length == 1
            for i in (0..self.length-1)
                if args[0] == self[i]
                    count += 1
                end
            end
        else
            for i in self
                count += 1
            end
        end
        return count
    end

    def my_map
        arr = []
        self.my_each { |x| arr << yield(x)}
        return arr
    end

    def my_inject(*args)
        add_up = 0
        if block_given? 
            my_each do |ele|
                yield(add_up, ele)
            end
        end
        return add_up
    end
    
    def multiply_els(arr)
        result = arr.my_inject { |product, n| product * n }
        return result
    end

end


p [3, 6, 10].my_inject {|sum, number| sum * number}
