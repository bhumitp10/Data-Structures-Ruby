class Node
	attr_accessor :val, :prevNode, :nextNode

	def initialize(val=nil, prevNode=nil, nextNode=nil)
		@val = val
		@prevNode = prevNode
		@nextNode = nextNode
	end

end

class List
	include Enumerable
	

	attr_reader :size
	attr_reader :tail

	def initialize
		@size = 0
		@head = nil
		@tail = nil
	end

	def add(val)

		newNode = Node.new(val, @tail)

		if size == 0
			@head = newNode 
		else
			@tail.nextNode = newNode
		end

		@tail = newNode
		@size += 1
	end

	def insert(val, pos)

		newNode = Node.new(val)
		count = 0
		cur = @head

		while count != pos && cur != nil do
			cur = cur.nextNode
			count += 1
		end

		if pos == 0
			newNode.nextNode = cur
			@head = newNode

			if size == 0
				@tail = newNode
			else
				cur.prevNode = newNode
			end

		else 
			newNode.nextNode = cur
			newNode.prevNode = cur.prevNode
			cur.prevNode.nextNode = newNode

			if cur == nil
				@tail = newNode
			end

		end

		@size += 1

	end	

	def remove(val)

		if @size == 0
			return
		end

		temp = @head

		while temp != nil && temp.val != val do
			temp = temp.nextNode
		end

		if temp == nil
			return
		end

		if temp.prevNode == nil && temp.nextNode == nil
			@head = nil
			@tail = nil
		elsif temp.prevNode == nil
			@head = temp.nextNode
			temp.nextNode.prevNode = nil
		elsif temp.nextNode == nil
			temp.prevNode.nextNode = nil
			@tail = temp.prevNode
		else 
			temp.prevNode.nextNode = temp.nextNode
			temp.nextNode.prevNode = temp.prevNode
		end


		@size -=1
	end

	def search(val)
		cur = @root

		while cur != nil && cur.val != val do
			cur = cur.nextNode
		end

		if cur.val == val
			return true
		end

		return false
	end


	def pop
		if @size == 0
			return
		end

		@head.nextNode.prevNode = nil
		@head = @head.nextNode
		@size -=1
	end

	def push(val)
		newNode = Node.new(val, nil, @head)
		@head.prevNode = newNode
		@head = newNode
		@size += 1
	end

	def remove_pos(pos)
		if @size == 0
			return
		end

		temp = @head
		count = 0

		while temp != nil && pos != count do
			temp = temp.nextNode
			count += 1
		end

		if temp == nil
			return
		end

		if temp.prevNode == nil
			@head = temp.nextNode
			temp.nextNode.prevNode = nil
		elsif temp.nextNode == nil
			temp.prevNode.nextNode = nil
			@tail = temp.prevNode
		else 
			temp.prevNode.nextNode = temp.nextNode
			temp.nextNode.prevNode = temp.prevNode
		end


		@size -=1
	end

	def each(&block)
		temp = @head
		while temp != nil do
			 block.call(temp.val)
			temp = temp.nextNode
		end
	end	

	def <<(val)
		add(val)
	end

	def print_list

		temp = @head
		puts
		while temp != nil do
			puts temp.val
			temp = temp.nextNode
		end		
		puts
	end

	def print_reverse
		temp = @tail
		puts
		while temp != nil do
			puts temp.val
			temp = temp.prevNode
		end
		puts
	end
end


list = List.new
