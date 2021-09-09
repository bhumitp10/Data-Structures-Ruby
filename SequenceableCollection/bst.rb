require_relative "SequenceableCollection.rb"

class Node
	attr_accessor :key, :value, :left, :right

	def initialize(key=nil, value = nil , left=nil,right=nil)
		@key = key
		@value = value
		@left = left
		@right = right
	end
end


class BST < SequenceableCollection


	def initialize
		@size = 0
		@root = nil
		@count = 0
		@flag = false
		@x = nil
	end

	# insert (key,value) pair 

	def insert(key,value)

		if @root == nil # base case

			@root = Node.new(key,value)
			return

		end
								# find the node to insert the new pair
		cur = @root    
		prev = nil

		while cur != nil do

			if key == cur.key   # found

				prev.value = value
				return

			elsif key < cur.key     # go left

				prev = cur
				cur = cur.left

			else						# go right

				prev = cur
				cur = cur.right

			end

		end

		if key < prev.key           

			prev.left = Node.new(key,value)

		else

			prev.right = Node.new(key,value)

		end

		@size += 1 
	end

	def remove(key)
		cur = @root
		prev = nil

		while cur != nil 			# find pair to delete

			if cur.key == key

				break

			elsif key < cur.key

				prev = cur
				cur = cur.left

			else

				prev = cur
				cur = cur.right

			end

		end

		if cur.key != key

			return

		elsif cur.left == nil && cur.right == nil   # leaf node

			if prev == nil
				@root = nil
			elsif prev.key > cur.key
				prev.left = nil
			else
				prev.right = nil
			end

		elsif cur.left != nil && cur.right == nil     # node extends only to left

			if prev == nil
				@root = cur.left
			elsif prev.key > cur.key
				prev.left = cur.left				
			else
				prev.right = cur.left
			end
		elsif cur.left == nil && cur.right != nil     # node extends only to right

			if prev == nil
				@root = cur.right
			elsif prev.key > cur.key
				prev.left = cur.right				
			else
				prev.right = cur.right
			end
		else									# node extends to both right and left

			temp = cur.right

			while temp.left != nil do        # find the successor of the node to be deleted
				temp = temp.left
			end

			newNode = Node.new(temp.key, temp.value, cur.left, cur.right)   # create new node so value can be swapped

			if temp == cur.right
				newNode.right = nil
			end

			self.remove(temp.key)         #  remove the sucessor node, since we will swap the node to be
										# delete with a copy of the successsor node


			if prev == nil    
				@root = newNode
			elsif prev.key > cur.key
				prev.left = newNode				
			else
				prev.right = newNode
			end
		end
		@size -=1
	end


	def at_index(i)

		@count = 0
		inorder(i, @root)
		return @x

	end

	def print_all
		puts
		print_inorder(@root)
		puts
	end

	private

	def print_inorder(cur)

		if cur == nil
			return
		end
		print_inorder(cur.left)
		puts "Key:#{cur.key} Value:#{cur.value}"
		print_inorder(cur.right)
	end

	def inorder( i, cur)
		
		if cur == nil 
			return
		end

		if cur.left != nil

			inorder(i,cur.left)
		end



		if @count == i
			@x = cur.value
		end

		@count += 1

		if cur.right != nil

			inorder(i, cur.right)
		end		

	end





end

times_two = -> (x) { x * 2 }



bst = BST.new
bst.insert(1,"1")
bst.insert(10, "10")
bst.insert(0 , "0")
bst.insert(3, "3")
bst.insert(5, "5")
bst.insert(-1,"-1")
bst.insert(12,"12")

bst.print_all
puts 
bst.each(times_two) {|a| p a}
puts


#bst.print_all




#bst.remove(10)

#bst.print_all

#bst.insert(11, "11")
#bst.insert(14, "14")
#bst.print_all

#puts bst.index_at(6)