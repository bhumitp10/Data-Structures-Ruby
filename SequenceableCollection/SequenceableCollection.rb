class SequenceableCollection

	attr_reader :size

	def initialize
		@size = 0
	end


	def insert(val)
		
	end

	def remove(val)

	end

	def at_index(i)

	end

	def each(func)

		for i in (0...@size) do
			val = self.at_index(i)
			
			yield func.call(val)
			#yield method(func(val)).call

		end
	end

end