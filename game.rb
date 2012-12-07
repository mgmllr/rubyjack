$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'deck'
require 'player'

class Game

	attr_accessor :deck, :user, :dealer

	def initialize
		@deck = create_deck
		@user = User.new
		@dealer = Dealer.new

		puts "Hello, welcome to RubyJack!"
		first_deal
		play_game
	end

	def create_deck
		deck = Deck.new
		deck.shuffle!
		deck
	end


	def first_deal
		2.times do
		 	@user.hand << @deck.pop
		 	@dealer.hand << @deck.pop
		end
		
		puts "Your cards are:\n#{@user.hand}"
		puts
		puts "The dealer is showing:\n#{@dealer.hand[0]}"
		puts 
	end
	
	def play_game
		unless @user.busted?
			new_turn_user
			unless @dealer.busted?
				new_turn_dealer
			end
			check_score
		end
	end

	def new_turn_user
		puts "Would you like to hit or stand?"
		reply = gets.chomp.downcase
		if reply == "hit"
			@user.hand << @deck.pop
			puts "Your cards are:\n#{@user.hand}"
			puts
			unless @user.busted?
				new_turn_user
			end
		elsif reply == "stand"
		else 
			puts "Please enter a valid reply."
			new_turn_user
		end
	end

	def new_turn_dealer
		unless (@dealer.total >= 17)
			@dealer.hand << @deck.pop
			new_turn_dealer
		end
	end

	def check_score
		if @user.busted? && !@dealer.busted?
			puts
			puts "Bummer...you busted."
		end

		if @user.blackjack? && !dealer.blackjack?
			puts
			puts "BLACKJACK!"
		end

		if (@user.total > @dealer.total && @user.total < 22) || (@dealer.total > 21 && @user.total < 22) 
			puts
			puts "YOU WIN!"
			puts
		elsif @user.total == @dealer.total
			puts
			puts "You and the dealer tie."
			puts 
		elsif @dealer.busted? && @user.busted?
			puts "You both busted...push."
			puts
		else
			puts "You lose :( Game over!"
		end
		puts "The dealer had:\n#{@dealer.hand}"
		puts
	end

	
end

game = Game.new

loop do
	puts "Would you like to play again?"
	reply = gets.chomp.downcase
	if reply == 'yes' || reply == 'y'
		new_game = Game.new
	else
		puts "Goodbye!"
		break
	end
end