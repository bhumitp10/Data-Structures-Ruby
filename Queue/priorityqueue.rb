require_relative 'queue.rb'

# Pair was developed to store a value along with its priority, this makes it easier to store it 
# in the Priority Queue.

class Pair

	attr_accessor :value       #stores the value of the queue
	attr_reader :priority      #priority of the stored value

	def initialize(value, priority)
		@value = value 		  # set value
		@priority = priority  # sets priority
	end

end


# PriorityQueue : Stores the value along with the priority in a binary heap. The Queue can 
# prioritize higher or lower value, depending on which is passed to the constructor.

class PriorityQueue < Queue 

	def initialize(sort = :higher)

		super() # call constructor of super class
		@sort = sort   # set sort order

	end


	# Inserts the value along with the priority, the time complexity is O(lgn N) where N is 
	# the size of the queue.

	def insert(value, priority)

		@arr[@size] = Pair.new(value, priority)  # store the pair at the end of the array

		if !self.is_empty()  # check if queue is empty

			cur = @size   # set cur to size

			parent = get_parent(cur)  # get parent of the current index

			while parent != nil do  # parent is not nil

				if compare(cur,parent)  # returns true if first param has higher priority than second

					swap(cur, parent)  # swap cur and parents
					cur = parent

				else  # no need to traverse up the list
			
					break

				end

				parent = get_parent(cur) # get parent of current indec

			end

		end

		@size += 1  # increase size
	end

	# Removes the pop with the highest priority, and cost of removal is O(lgn N).  

	def remove()

		if @size == 0   # empty cannot remove
			return
		end

		swap(0, @size - 1)  # swap the first and last indecies

		@size -= 1    # decrease size
		cur = 0 
		child = get_child(cur)

		# loop until child is nil and child index is valid

		while child != nil and child < @size do

			if 	!compare(cur,child)	# if first param does not have greater priority
				#puts "Cur : #{cur} Child : #{child}"

				swap(cur,child) # swaps the cur and child indecies
				cur = child 
			else
				break
			end	

			child = get_child(cur) # get the child of current index

		end	

		return @arr[@size]
	end


	private 

	# Gets the parent of the given array index

	def get_parent(idx) 

		if idx == 0
			return  nil
		end

		parent = ((idx - 1)/2).round() # compute the parent index

		return parent
	end

	# Gets the child of the given position in the array, the proper value  depending on the sort order is returned, so it can 
	# compared too.

	def get_child(pos)

		index1 = 2*pos + 1   
		index2 = 2*pos + 2

		if index1 >= @size  # invalid index1 and index2

			return nil

		elsif index2 >= @size # invalid index2, so return index1
					
			return index1

		end

		child1 = @arr[ 2*pos + 1 ] # get child1
		child2 = @arr[ 2*pos + 2 ] # get child2

		if @sort == :higher  # sort order prioritizes higher

			if child1.priority > child2.priority  # child1 is greater, higher priority
				return index1  
			else
				return index2
			end

		else # sort order prioritizes lower

			if child1.priority < child2.priority # child1 is lesser, higher priority
				return index1
			else
				return index2
			end

		end

	end


	# compares priority at two index1 and return true if first parameter has higher priority based on sort order

	def compare(index1, index2)

		if @sort == :higher
			
			return @arr[index1].priority > @arr[index2].priority

		else

			return @arr[index1].priority < @arr[index2].priority

		end

		return false
	end

	# swap the values at two indeces

	def swap(index1, index2)

		temp = @arr[index1]
		@arr[index1] = @arr[index2]
		@arr[index2] = temp

	end

	public

	def print_all
		if @size == 0
			puts "printed"
			return
		end

		for i in 0...@size do
			puts "Index : #{i} " + "Value : " + @arr[i].value.to_s + " Priority : " + @arr[i].priority.to_s
		end
	end


end

#queue = PriorityQueue.new(:lower)


class Node

end



$rows = 10
$cols = 10


arr_2d = []

for i in 0..$rows do

	arr_2d.append(Array.new)

	for j in 0..$cols do
		arr_2d[i].append(false)
	end
end


def print_all(arr_2d)

	for i in 0..$rows do

		for j in 0..$cols do

			if !arr_2d[i][j]
				print "* "
			else
				print ". "
			end
		end
		puts
	end

end

def dist(arr1, arr2)
	distx = (arr1[0] - arr2[0]).abs
	disty = (arr1[1] - arr2[1]).abs

	return distx + disty
end

def get_neighbors(arr1)
	neighbors = []

	x1, y1 = arr1

	if x1 > 0 
		neighbors << ([x1 - 1, y1])
	end

	if x1 < $rows - 1 
		neighbors << ([x1 + 1, y1])
	end

	if y1 > 0
		neighbors << ([x1, y1 - 1])
	end

	if y1 < $cols - 1
		neighbors << ([x1, y1  + 1])
	end

end



start1 = [1,1]
end1 = [6,7]


queue = PriorityQueue.new(:lower)
pred = Hash.new
queue.insert(start1,dist(start1,end1))
pred[start1] = nil
visited = Hash.new
cost = Hash.new 
num = start1[0]* $rows + start1[1]
cost[num] = dist(start1,end1)

while !queue.is_empty do
	cur = queue.remove
	p1 = cur.value

	x = p1[0]
	y = p1[1]

	if p1 == end1
		arr_2d[x][y] = true
		break
	end	

	arr_2d[x][y] = true

	visited[[x,y]] = 1

	neighbors = get_neighbors([x,y])

	num = start1[0]* $rows + start1[1]


	for neighbor in neighbors do

		if !visited.key?(neighbor)

			dist_cost = dist(neighbor, end1)

			new_cost = dist_cost + cost[num] + 1

			if !cost.key?(neighbor) || new_cost < cost[neighbor] 
				cost[neighbor[0]* $rows + neighbor[1]] = new_cost
				pred[neighbor] = cur
				queue.insert(neighbor,dist(neighbor,end1))
			end

		end

	end


end


print_all(arr_2d)










#queue = PriorityQueue.new(:lower)
#queue.insert("bp", 14)
#queue.insert("asf", 120)
#queue.insert("ra", 124)
#queue.insert("a12", 15)
#queue.insert("a13", 140)
#queue.insert("a12", 315)
#queue.insert("a13", 1140)
#puts "Size : #{queue.size}"
#queue.print_all
#queue.remove()
#puts "Size : #{queue.size}"
#puts
#queue.print_all
#queue.remove()
#puts "Size : #{queue.size}"
#puts
#queue.print_all