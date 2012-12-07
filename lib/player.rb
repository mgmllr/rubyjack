$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'deck'


class Player
	
	attr_accessor :hand

	def initialize
		@hand = []
		@busted = false
	end

	def total
		score = 0
		@hand.each do |card|
			score = score + card[:value]
		end
		score
	end

	def blackjack?
		if self.total == 21
			return true
		end
	end

	def soft?
		@hand.each do |card|
			return card if card.soft_ace?
		end
		nil
	end

	def busted?
		if (self.total > 21)
			ace = soft?
			if (ace)
				ace[:value] =  1
				return false
			end
			return true 
		end
		false 
	end

#	def to_s
#		"#{self.hand}, #{self.total}"
#	end
end

class User < Player

end

class Dealer < Player

end