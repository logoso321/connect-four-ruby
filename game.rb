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
				return location
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

	def Game.check_win(player, location)
		win = false
		if(location == nil)
			return false
		end
		neighbors = []
		#Get all neighbors of location with the direction from the piece
		@@board.each do |loc, val|
			if((loc[0] - location[0]) == -1)
				if((loc[1] - location[1]) == -1)
					neighbors << [loc, "NW"]
				elsif((loc[1] - location[1]) == 0)
					neighbors << [loc, "W"]
				elsif((loc[1] - location[1]) == 1)
					neighbors << [loc, "SW"]
				end
			elsif((loc[0] - location[0]) == 0)
				if((loc[1] - location[1]) == -1)
					neighbors << [loc, "N"]
				elsif((loc[1] - location[1]) == 1)
					neighbors << [loc, "S"]
				end		
			elsif((loc[0] - location[0]) == 1)
				if((loc[1] - location[1]) == -1)
					neighbors << [loc, "NE"]
				elsif((loc[1] - location[1]) == 0)
					neighbors << [loc, "E"]
				elsif((loc[1] - location[1]) == 1)
					neighbors << [loc, "SE"]
				end		
			end
		end
		#selects only the neighboring locations that have the same tag ("x" or "o") as player
		neighbors.select! {|loc, dir| @@board[loc] == player}

		neighbors.each do |loc, direction|
			win = Game.path(loc,direction,player)
			if(win == true)
				return true
			end
		end

		#returns false if previous loop doesnt return true (no winning combination)
		return false
	end

	def Game.path(location, direction, player)
		list = []

		case direction
		when "N"
			list = Game.next_two(location, 0, -1)
		when "NE"
			list = Game.next_two(location, 1, -1)
		when "NW"
			list = Game.next_two(location, -1, -1)
		when "E"
			list = Game.next_two(location, 1, 0)
		when "W"
			list = Game.next_two(location, -1, 0)
		when "S"
			list = Game.next_two(location, 0, 1)
		when "SE"
			list = Game.next_two(location, 1, 1)
		when "SW"
			list = Game.next_two(location, -1, 1)
		end

		counter = 0
		list.each do |x|
			if(@@board[x] == player)
				counter += 1
			end
		end

		if(counter == 2)
			return true
		else return false
		end
	end

	def Game.next_two(location, xdif, ydif)
		list = []
		list << [location[0] + xdif, location[1] + ydif]
		list << [location[0] + (2*xdif), location[1] + (2*ydif)]
		return list
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
		#Player 1 last location
		#Player 2 last location
		winner = ""
		p1 = nil
		p2 = nil

		until Game.check_win("|o|", p1) || Game.check_win("|x|", p2) || Game.check_tie do
			show_board(@@board, 7)
						
			p1 = Game.input("Player 1", "o")
			if(Game.check_win("|o|", p1) || Game.check_tie)
				break
			end	
			p2 = Game.input("Player 2", "x")
			if(Game.check_win("|x|", p2) || Game.check_tie)
				break
			end	
		end

		if(Game.check_win("|o|", p1))
			print("\nPlayer 1 has won the game!\n")
		elsif(Game.check_win("|x|", p2))
			print("\nPlayer 2 has won the game!\n")
		elsif(Game.check_tie)
			print("\nGame resulted in a tie")
		end
		show_board(@@board, 7)
	end
end

a = Game.new
a.play