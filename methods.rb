# rubocop:disable all"
...
# rubocop:enable all

module Enumerable
	def my_each
		return to_enum if !block_given?

	  for i in (0..self.length - 1)
		  yield(self[i])
		end
	end

	def my_each_with_index
		return to_enum if !block_given?

	  for i in (0..self.length - 1)
		  yield(self[i], i)
		end
	end

  def my_select
		arr = []
		return to_enum if !block_given?

		my_each { |x| arr << x if yield(x) }
		return arr
	end

  def my_all?(pattern = nil)
	  result = true
		if block_given?
			self.my_each do |x|
				result = false if !yield(x)
				break if !result
			end
		elsif pattern.class == Regexp
			self.my_each do |x|
				result = false if !x.match(pattern)
				break if !result
			end
		elsif pattern
			self.my_each do |x|
				result = false if pattern != x
				break if !result
			end
		else
			for i in self
				result = false if !i
				break if !result
			end
		end
		return result
	end

  def my_any?(pattern = nil)
		result = false
		if block_given?
			self.my_each do |x|
				result = true if yield(x)
				break if result
			end
		elsif pattern.class == Regexp
			self.my_each do |x|
				result = true if x.match(pattern)
				break if result
			end
		elsif pattern
			self.my_each do |x|
				result = true if x == pattern
				break if result
			end
		else
			for i in self
				result = true if i
				break if result
			end
		end
		return result
	end

  def my_none?(pattern = nil)
		result = false
		if block_given?
			self.my_each { |x| result = true if !yield(x) }
		elsif pattern.class == Regexp
			self.my_each { |x| result = true if !x.match(pattern) }
		elsif pattern
			self.my_each { |x|result = true if x != pattern }
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
			for i in (0..self.length - 1)
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

  def my_map(&my_proc)
		arr = []
		return to_enum unless block_given?

		if !my_proc
			self.my_each { |x| arr << yield(x) }
		else
			self.my_each { |x| arr << my_proc.call(x)}
		end
		return arr
	end

  def my_inject(*args)
		check = args.length > 0
		arr = if self.is_a? Array
						self
					elsif self.is_a? Range
						self.to_a
					end

		sym = args[0].is_a? Symbol
		sym1 = args[1].is_a? Symbol

		acc = if args.length == 0 || sym
						arr[0] 
					elsif args.length > 0 || sym1
						args[0]
					end

			if  sym 
				arr.drop(1).my_each do |x|
					block = lambda { |memo, val| memo.send(args[0], val) }
					acc = block.call(acc, x)
				end
			elsif check && sym1
				arr.drop(0).my_each do |x|
					block = lambda { |memo, val| memo.send(args[1], val) }
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
			return acc
	end

end

def multiply_els(arr)
	return arr.my_inject { |product, n| product * n }
endc