class TrieNode
	attr_accessor :nodes,:end

	def initialize(end1 = false)
		@nodes = Hash.new
		@end = end1
	end
end 

class Trie
	include Enumerable

	attr_accessor :root
	attr_reader :size

	def initialize
		@root = TrieNode.new
		@size = 0
	end

	def insert(word)
		cur = @root

		word.each_char do |x|
			if cur.nodes.key?(x)
				cur = cur.nodes[x]
			else
				node = TrieNode.new
				cur.nodes[x] = node
				cur = node
			end
		end

		if cur.nodes.key?('end')
			return
		end

		cur.nodes['end'] = TrieNode.new(true)	
		@size +=1	
	end

	def delete(word)
		cur = @root
		arr = word.split('')
		remove_nodes(arr, 0, arr.length, cur)
	end

	def remove_nodes(arr, pos, max, cur)
		if cur == nil || pos > max
			return
		elsif pos < max 
			letter = arr[pos]
			remove_nodes(arr, pos + 1, max, cur.nodes[letter])
		else pos == max
			if cur.nodes.key?('end')
				cur.end = false
				cur.nodes.delete('end')
				@size -=1
			end
			return
		end

		letter = arr[pos]
		if(cur.nodes.key?(letter) && cur.nodes.empty? )
			cur.nodes.delete(letter)
		end

	end

	def print_all
		puts get_all
	end

	def each(&block)
		arr = get_all
		arr.each {|x| block.call(x)}
	end

	def get_all
		cur = @root
		arr = Array.new
		recur(cur,arr,"")
		return arr
	end	


	def search(word)
		cur = @root

		word.each_char do |x| 
			if !cur.nodes.key?(x)
				return false
			end
			cur = cur.nodes[x]
		end

		return cur.nodes.key?('end')
	end


	def recur(cur, arr, str)
		if cur == nil
			return
		else
			cur.nodes.each_pair do |key,value|
				if key == 'end'
					arr << str
				end
				recur(value, arr, str + key)
				
			end		
		end

	end

end

trie = Trie.new
trie.delete("a")
trie.insert("abc")
trie.insert("abcd")
trie.insert("abgl")
puts trie.size
puts trie.map {|x| x*3}
trie.delete("abc")
puts trie.size
trie.print_all
puts trie.search("abgd")