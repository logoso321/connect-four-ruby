require "matrix"

class Game
	attr_accessor :board
	@@board = Hash.new(0)

	def initialize
		#Creates a 7x6 connect four board
		counter_x = 1
		counter_y = 1
		@elements = [counter_x, counter_y]
		for i in 0..41
			@@board[@elements] = "|#{counter_x}|"
			counter_x += 1
			if(counter_x == 8)
				counter_x = 1
				counter_y += 1
			end
			@elements = [counter_x,counter_y]
		end
	end

	def board
		@@board
	end

	def show_board(hash, width)
		print("\n")
		hash.each do |x,y|
			print("#{y} ")
			#indents the game board for a new line
			if(x[0] % width == 0)
				print("\n")
			end
		end
		print("\n\n")
	end

	def Game.input

	end

	def Game.check_win

	end

	def Game.check_tie

	end

	def play
		show_board(@@board, 7)
		p1 = 0
		p2 = 0
		winner = ""

		#If player 1 wins, check_win = 1, if player 2 wins, check_win = 2.
		until Game.check_win == 1 || Game.check_win == 2 || Game.check_tie do
			Game.check_tie
			
			p1 = Game.input
			p2 = Game.input

			Game.check_win

		end


	end
end

a = Game.new
a.play