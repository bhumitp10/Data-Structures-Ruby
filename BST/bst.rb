class Node
	attr_accessor :key, :value, :left, :right

	def initialize(key=nil, value = nil , left=nil,right=nil)
		@key = key
		@value = value
		@left = left
		@right = right
	end
end


class BST
	attr_accessor :root
	attr_reader :size

	def initialize
		@root = nil
		@size = 0
	end

	def insert(key,value)

		cur = @root
		prev = nil

		while cur != nil do

			if key == cur.key
				break
			elsif key < cur.key
				prev = cur
				cur = cur.left
			else
				prev = cur
				cur = cur.right
			end
		end

		if prev == nil
			@root = Node.new(key,value)
		elsif key == prev.key
			prev.value = value
			return
		elsif key < prev.key
			prev.left = Node.new(key,value)
		else
			prev.right = Node.new(key,value)
		end

		@size += 1 
	end

	def delete(key)
		cur = @root
		prev = nil

		while cur != nil

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

		elsif cur.left == nil && cur.right == nil

			if prev == nil
				@root = nil
			elsif prev.key > cur.key
				prev.left = nil
			else
				prev.right = nil
			end

		elsif cur.left != nil && cur.right == nil

			if prev == nil
				@root = cur.left
			elsif prev.key > cur.key
				prev.left = cur.left				
			else
				prev.right = cur.left
			end
		elsif cur.left == nil && cur.right != nil

			if prev == nil
				@root = cur.right
			elsif prev.key > cur.key
				prev.left = cur.right				
			else
				prev.right = cur.right
			end
		else

			temp = cur.right

			while temp.left != nil do
				temp = temp.left
			end

			newNode = Node.new(temp.key, temp.value, cur.left, cur.right)

			if temp == cur.right
				newNode.right = nil
			end

			self.delete(temp.key)

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


	def search(key)
		return search_helper(key,@root)
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

	def search_helper(key, cur)

		if cur == nil
			return false
		elsif  cur.key == key
			return true
		elsif key < cur.key
			return search_helper(key, cur.left)
		else
			return search_helper(key, cur.right)
		end

	end
	
end

bst = BST.new
bst.insert(9,"9")
bst.insert(11,"11")
bst.insert(10,"10")
bst.insert(13,"13")
bst.insert(8,"8")
bst.insert(12,"12")
bst.insert(14,"14")
bst.insert(8.6,"8.6")
bst.insert(12.5, "12.5")

puts

bst.print_all
bst.delete(11)
bst.print_all
puts bst.search(9)
