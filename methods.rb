module Enumerable
  def my_each
    return to_enum unless block_given?

    (0..length - 1).each do |i|
      yield(self[i])
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    (0..length - 1).each do |i|
      yield(self[i], i)
    end
    self
  end

  def my_select
    arr = []
    return to_enum unless block_given?

    my_each { |x| arr << x if yield(x) }
    arr
   end

  def my_all?(pattern = nil)
    result = true
    if block_given?
      my_each do |x|
        result = false unless yield(x)
        break unless result
      end
    elsif pattern.class == Regexp
      my_each do |x|
        result = false unless x.match(pattern)
        break unless result
      end
    elsif pattern
      my_each do |x|
        result = false unless pattern === x
        break unless result
      end
    else
      each do |i|
        result = false unless i
        break unless result
      end
    end
    result
   end

  def my_any?(pattern = nil)
    result = false
    if block_given?
      my_each do |x|
        result = true if yield(x)
        break if result
      end
    elsif pattern.class == Regexp
      my_each do |x|
        result = true if x.match(pattern)
        break if result
      end
    elsif pattern
      my_each do |x|
        result = true if pattern === x
        break if result
      end
    else
      each do |i|
        result = true if i
        break if result
      end
    end
    result
   end

  def my_none?(pattern = nil)
    result = true
    if block_given?
      my_each do |x|
        result = false if yield(x)
        break unless result
      end
    elsif pattern.class == Regexp
      my_each do |x|
        result = false if x.match(pattern)
        break unless result
      end
    elsif pattern
      my_each do |x|
        result = false if pattern === x
        break unless result
      end
    else
      each do |i|
        result = false if i
        break unless result
      end
    end
    result
   end

  def my_count(*args)
    count = 0
    if block_given?
      my_each { |x| count += 1 if yield(x) }
    elsif args.length == 1
      (0..length - 1).each do |i|
        count += 1 if args[0] == self[i]
      end
    else
      each do |_i|
        count += 1
      end
    end
    count
   end

  def my_map(&my_proc)
    arr = []
    ary = (is_a? Array) ? self : to_a

    return to_enum unless block_given?

    if !my_proc
      ary.my_each { |x| arr << yield(x) }
    else
      ary.my_each { |x| arr << my_proc.call(x) }
    end
    arr
   end

  def my_inject(*args)
    check = !args.empty?
    arr = (is_a? Array) ? self : to_a

    sym = args[0].is_a? Symbol
    sym1 = args[1].is_a? Symbol

    acc = if args.empty? || sym
            arr[0]
          elsif !args.empty? || sym1
            args[0]
          end

    if sym
      arr.drop(1).my_each do |x|
        block = ->(memo, val) { memo.send(args[0], val) }
        acc = block.call(acc, x)
      end
    elsif check && sym1
      arr.drop(0).my_each do |x|
        block = ->(memo, val) { memo.send(args[1], val) }
        acc = block.call(acc, x)
      end
    elsif check
      arr.drop(0).my_each { |x| acc = yield(acc, x) }
    elsif check && block_given?
      arr.drop(0).my_each { |x| acc = yield(acc, x) }
    elsif !check && block_given?
      arr.drop(1).my_each { |x| acc = yield(acc, x) }
    elsif !check
      arr.drop(0).my_each { |x| acc = yield(acc, x) }
    end
    acc
   end
end

def multiply_els(arr)
  arr.my_inject { |product, n| product * n }
end
