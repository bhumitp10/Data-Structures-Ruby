
class Node
	attr_accessor :val, :nextNode

	def initialize(val=nil, nextNode=nil)
		@val = val
		@nextNode = nextNode
	end

end

class List
	include Enumerable
	attr_reader :size

	def initialize
		@size = 0
		@head = nil
		@tail = nil
	end

	def add(val)

		newNode = Node.new(val,nil)

		if size == 0
			@head = newNode 
			@tail = newNode
			@size +=1
		else
			@tail.nextNode = newNode
			@tail = newNode
			@size +=1
		end

	end

	def insert(val, pos)

		newNode = Node.new(val)
		count = 0
		cur = @head
		prev = nil

		while count != pos && cur != nil do
			prev = cur
			cur = cur.nextNode
			count += 1
		end

		if pos == 0
			newNode.nextNode = @head
			@head = newNode

			if size == 0
				@tail = newNode
			end

		else 
			newNode.nextNode = cur
			prev.nextNode = newNode

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
		prev = nil

		while temp != nil && temp.val != val do
			prev = temp
			temp = temp.nextNode
		end

		if temp == nil
			return
		end

		if prev == nil
			@head = temp.nextNode
		else 
			prev.nextNode = temp.nextNode
		end

		if temp.nextNode == nil
			@tail = prev
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

		@head = @head.nextNode
		@size -=1
	end

	def push(val)
		newNode = Node.new(val, @head)
		@head = newNode
		@size += 1
	end

	def remove_pos(pos)
		if @size == 0
			return
		end

		temp = @head
		prev = nil
		count = 0

		while temp != nil && pos != count do
			prev = temp
			temp = temp.nextNode
			count +=1
		end

		if temp == nil
			return
		end

		if prev == nil
			@head = temp.nextNode
		else 
			prev.nextNode = temp.nextNode
		end

		if temp.nextNode == nil
			@tail = prev
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

	end

end

list = List.new
list.remove(0)
list.add("Bhumit")
list.add("10")
list.add("Ruby")
list.print_list
puts list.size
list.remove_pos(0)
list.print_list
puts list.size
p list.map{|x| x*2}

