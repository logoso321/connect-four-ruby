require './spec_helper'

describe Game do 

	before :each do
		@game = Game.new
	end

	describe "#new" do
		it "is an instance of Game" do
			expect(@game).to be_a Game
		end

		it "fills the game board" do
			expect(@game.board.length).to eql 42
		end
	end

	describe "#play" do
		
	end
	
end