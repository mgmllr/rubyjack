class Deck < Array

	attr_accessor :cards

	SUITS = ["Clubs", "Diamonds", "Hearts", "Spades"]

	def initialize
		super
		SUITS.each do |suit|
			push(Card[value: 11, suit: suit, card: "Ace"])
			(2..10).each {|n| push(Card[value: n, suit: suit, card: n])}
			['Jack', 'Queen', 'King'].each {|f| push(Card[value: 10, suit: suit, card: f])}
		end	

		self

	end

	class Card < Hash

		def soft_ace?
			self[:card] == 'Ace' && self[:value] == 11
		end

		def to_s	
			"#{self[:card]} of #{self[:suit]}"
		end

		def inspect
			to_s
		end
	end
end
