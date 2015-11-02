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

	def Game.input(player, piece)
		choice = -1
		while choice.to_i < 1 || choice.to_i > 7 
			print("#{player} choose a slot (1-7): ")
			choice = gets.chomp.to_i
		end

		column = Game.get_column(choice)
		if(column.empty?)
			puts "Full column"
			Game.input(player,piece)
		end

		queue = []
		column.each do |x|
			queue << x
		end
		#Flips queue so that the end of the column is the first checked
		queue.reverse!
		#Places a piece in the #choice column 
		until queue.empty?
			location = queue.shift
			if(@@board[location] == "|#{choice}|")
				@@board[location] = "|#{piece}|"
				return true
			else next
			end
		end

	end

	def Game.get_column(column)
		list = []
		index = column
		@@board.each do |location,x|
			#Adds the location of each board piece in the column
			if(x == "|#{index}|")
				list << location
			end
		end
		return list
	end

	def Game.check_win(player)
		
	end

	def Game.check_tie
		#If there are any remaining open slots, return false
		@@board.each do |location,x|
			if(x == "|1|" || x == "|2|" || x == "|3|" || x == "|4|" || x == "|5|" || x == "|6|" || x == "|7|")
				return false
			end
		end
		#All slots are filled, return true
		return true
	end

	def play
		p1 = 0
		p2 = 0
		winner = ""

		#If player 1 wins, check_win = 1, if player 2 wins, check_win = 2.
		until Game.check_win == 1 || Game.check_win == 2 || Game.check_tie do
			show_board(@@board, 7)
						
			p1 = Game.input("Player 1", "o")
			Game.check_win("|o|")
			Game.check_tie
			p2 = Game.input("Player 2", "x")
			Game.check_win("|x|")		
			Game.check_tie
		end

		if(Game.check_tie)
			print("\nGame resulted in a tie")
		end
	end
end

a = Game.new
a.play