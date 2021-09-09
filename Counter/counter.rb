class Counter
	include Enumerable

	attr_reader :size

	def initialize
		@size = 0
		@counter = Hash.new
	end

	def insert(val)
		cur_count = @counter[val]

		if cur_count == nil
			@size += 1
			@counter[val] = 1 
		else
			@counter[val] = cur_count + 1
		end
	end

	def search(val)
		return @counter[val]
	end

	def print_all
		for key,value in @counter do
			puts "#{key} : #{value}"
		end
	end

	def each(&block)
		@counter.each{ |x,y| block.call(Array[x,y]) }
	end

end


def trim_word(word)
	word =  word.strip.sub(',', '').sub('.', '')
	word = word.sub("\”",'').sub("\“",'')
	word.downcase
end

def is_word(word)
	return word.index('(') == nil && word.index(')') == nil  && word.index('’') == nil && word.index('')
end


counter = Counter.new
arr = Array.new

file = File.open("essay.txt", "r")

file.readlines.each do |line| ' '""
	words = line.split(' ')

	for word in words do
		word = trim_word(word)

		if is_word(word)
			arr << word
		end
	end

end

file.close()



for word in arr do
	counter.insert(word)
end

#counter.print_all

counter.each{|x| p x}
puts counter.size
