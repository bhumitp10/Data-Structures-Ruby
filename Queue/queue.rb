class Queue
	include Enumerable
	attr_reader :size
	
	def initialize
		puts "initialize superclass"
		@arr = []
		@size = 0
	end

	public
	def insert(val)
		@arr.append(val)
		@size += 1
	end

	def remove()

		if @size == 0
			return
		end

		@size -= 1
		return @arr.shift
	end

	def is_empty()
		return @size == 0
	end

	def each
		@arr.each { |x|  yield x }
	end

	def print_all
		if @size == 0
			puts "printed"
			return
		end

		for i in 0..@size do
			puts @arr[i]
		end
	end

 
end


