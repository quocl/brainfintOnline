# Brainfuck interpreter in ruby 1.9.3
# There are 8 valid commands in brainfuck, which are: '>', '<', '+', '-', '.',',', '[' and  ']'
# Author: Quoc Le

class Brainfuck
	SIZE = 30000
	def initialize(input="")
		# initialize the brainfuck interpreter
		@data = Array.new(SIZE,0)   # data
		@pos = 0		    # data pointer 
		@program = input.gsub(/[^\>\<\.\,\+\-\[\]]/m, '').split('') # the brainfuck program
		@program_pos = 0   # brainfuck program pointer
		@depth = 0 #depth of the loop 
		@input = ""
		@input_pos = 0
		@output = ""
	end

	def move_right
		# function for '>'
		# increment the data pointer (to point to the next cell to the right).
		@pos += 1 unless @pos >= SIZE - 1
	end

	def move_left
		# function for '<'
		# decrement the data pointer (to point to the next cell to the left).
		@pos -= 1 unless @pos <= 0
	end 

	def increase
		# function for '+'
		# increment (increase by one) the byte at the data pointer.
		@data[@pos] += 1 
	end
	
	def decrease
		# function for '-'
		# decrement (decrease by one) the byte at the data pointer.
		@data[@pos] -= 1
	end
	
	def write
		# function for '.'
		# output the byte at the data pointer as an ASCII encoded character.
		@output += @data[@pos].chr
	end

	def read  
		# function for ','
		# accept one byte of input, storing its value in the byte at the data pointer.
		# tmp = $stdin.getc
		tmp = @input[@input_pos]
		@input_pos += 1
		@data[@pos] = tmp.ord
	end

	def jump_forward
		# function for '['
		@depth += 1
		current_depth = @depth
		if @data[@pos] == 0
			while @depth != current_depth - 1
				@program_pos += 1 
				if @program[@program_pos] == '['
					@depth += 1
				elsif @program[@program_pos] == ']'
					@depth -= 1
				end
			end
		else
			@program_pos += 1 
		end		
	end

	def jump_backward
		# function for ']'
		@depth -= 1
		current_depth = @depth
		if @data[@pos] != 0
			while @depth != current_depth - 1 
				@program_pos -= 1
				if @program[@program_pos] == ']'
					@depth += 1
				elsif @program[@program_pos] == '['
					@depth -= 1
				end
			end
		else
			@program_pos += 1 
		end
	end

	def eval program_input
		# evaluate the brainfuck program. Time limit is 15 seconds.
		@input = program_input
		t1 = Time.now
		while @program_pos < @program.size and Time.now - t1 < 15 
			if @program[@program_pos] != '[' and @program[@program_pos] != ']'				
				case @program[@program_pos]
				when '>'
					move_right
				when '<'
					move_left
				when '+'
					increase
				when '-'
					decrease
				when '.'
					write
				when ','
					read
				else
					puts "Invalid input: Unrecognized character #{@program[@program_pos]}"
				end
				@program_pos += 1 
			elsif @program[@program_pos] == '['
				jump_forward
			elsif @program[@program_pos] == ']'
				jump_backward
			end
		end
		return @output
	end
end
