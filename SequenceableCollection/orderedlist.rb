require_relative 'SequenceableCollection.rb'

class OrderedList < SequenceableCollection

	def initialize
		
		@arr = Array.new(8)
		@last = 3
		@first = 4
		@size = 0
		@max_cap = 8

	end

	def insert(val)   # insert element in an ordered position in the array, time complexity on average O(lg N)

		if @size == 0      # size is zero

			@arr[@first] = val
			@last += 1
			@size += 1
			return
		end

		if @first == 0 || @last == @max_cap - 1        # need to increase size
			self.resize
		end


		@size += 1                                    

		if @first == @last                      # inserting when size is 1

			if @arr[@first] < val

				@last += 1
				@arr[@last] = val
			else
				@first -= 1
				@arr[@first] = val
			end

			return
		end

		if val >= @arr[@last]                         # element being inserted is the highest

			@last += 1
			@arr[@last] = val
			return

		elsif val <= @arr[@first]                  # element being inserted is the lowest
			
			@first -= 1
			@arr[@first] = val
			return

		end

		pos = get_insertpos(@first, @last, val) + 1         # inserting element in the middle, get the position
		@arr.insert(pos, val)         

		@last += 1

	end

	def remove(val)

		if @size == 0 
			return
		end

		if @arr[@first] == val       # removing the first element

			@arr.delete_at(@first)
			@last -= 1
			@size -= 1
			return

		elsif @arr[@last] == val    # removing the last element

			@arr.delete_at(@last)
			@last -= 1
			@size -= 1
			return

		end

		pos = find_pos(val)         # removing element in the middle, find pos

		if pos == nil           # element being removed not in the list, just return
			return
		end

		@arr.delete_at(pos)           #  delete element

		@last -= 1 
		@size -= 1

	end

	def at_index(i)

		return @arr[@first + i]

	end


	def print_all

		puts
		puts "Size : #{@size}"


		if @size == 0

			puts ""
			return
		
		elsif @size == 1
		
			puts "#{@arr[@first]} "
			return
		
		end

		for i in @first..@last do 
			#print "Index : #{i} Val : #{@arr[i]} "
			print "#{@arr[i]} "
		end

		puts ""

	end

	def get_random

		return @arr[rand(@first..@last)]

	end


	private 

	def resize()

		new_cap = @max_cap * 2      
		new_arr = Array.new(new_cap)

		pos =(@max_cap/2).to_i 

		for i in @first..@last do         # copy element from old arr to new arr

			new_arr[i+pos] = @arr[i]

		end

		@max_cap = new_cap
		@arr = new_arr
		@last += pos                         
		@first += pos

	end

	# binary search to find the element to remove, time complexity O(lg N)
            
	def find_pos(val)

		#print_all
		#puts "First : #{@first} Last : #{@last}"

		low =  @first
		high = @last


		#puts "Val : #{val}"


		while low < high do

			middle = (low + high)/2

			#puts "Low : #{low} High : #{high} Middle : #{middle}"
 
			if @arr[middle] == val    # found element

				return middle

			elsif val > @arr[middle]     # element is on the higher side
					
				low = middle + 1

			else                          # element is on the lower side

				high = middle - 1
			end

		end

		return nil

	end



	def get_insertpos(low, high, val)

		middle = nil
		prev = nil

		while low < high do

			prev = middle
			middle = ((high+low)/2).to_i
			#puts "Low : #{low} High : #{high} Middle : #{middle}"

			if prev == middle
				break

			elsif val < @arr[middle] 

				high = middle

			elsif val >= @arr[middle]
				low = middle
			end
			
		end

		return middle

	end



end





arr =  OrderedList.new


#def x
#	return x * 2
#end

times_two = ->(x) { x * 2 }


arr.insert(14)
arr.insert(30)
arr.insert(15)
#arr.insert(20)
#arr.insert(11)

#arr.print_all

#arr.remove(14)


#for i in 1..400 do
#	x = rand(1..400)

#	if i % 5 == 0
#		arr.remove(arr.get_random)
#	end

#	print "#{x} "
#	arr.insert(x)
#end
#puts 
#puts
arr.each(times_two) {|a| p a}
#arr.each(:x)


arr.print_all
#arr.insert(9)
#arr.print_all
#arr.remove(15)
#arr.print_all
#arr.insert(16)
#arr.print_all
#arr.insert(8)
#arr.print_all
#puts arr.at_index(0)	