#class Card
	attr_accessor :value, :display, :suit, :nbr
	def initialize (value) 
	@value = value
	end
	def suit #show suit (heart, spade, etc)
		case value
		when 0..12
			suit = "SPADE"
		when 13..25
			suit = "HEART"
		when 26..38
			suit = "CLUB"
		when 39..51
			suit = "DIAMOND"
		end
	end
	def nbr #calculate card nbr value (2-14, 14 being ace)
		case value
		when 12, 25, 38, 51
			nbr = 14 #A = 14
		when 11, 24, 37, 50
			nbr = 13
		when 10, 23, 36, 49
			nbr = 12
		when 9, 22, 35, 48
			nbr = 11
		when 0..8
			nbr = value+2
		when 13..21
			nbr = value-11
		when 26..34
			nbr = value-24
		when 39..47
			nbr = value-37
		end
	end

	def display  #calculate playing card format
		case value
			when 12, 25, 38, 51
				display ="A"
			when 11, 24, 37, 50
				display ="K"
			when 10, 23, 36, 49
				display ="Q"
			when 9, 22, 35, 48
				display ="J"
			when 0..8
				display = [value+2].to_s
			when 13..21
				display = [value-11].to_s
			when 26..34
				display = [value-24].to_s
			when 39..47
				display = [value-37].to_s
		end

		case value
			when 0..12
				display += "\u2660".encode('utf-8') #SPADE
			when 13..25
				display += "\u2665".encode('utf-8') #HEART
			when 26..38
				display += "\u2663".encode('utf-8') #CLUB
			when 39..51
				display += "\u2666".encode('utf-8') #DIAMOND
		end
	end

end
class Player
	attr_accessor :name, :bank, :card1, :card2
	def initialize(name, bank) #loads all other initial player info
		@name = name
		@bank = bank
	end
end

class Deck
	$deck = []
	def load
		for inbr in 0..51
			$deck.push(inbr)
		end
	end
	def deal_card #get a random card from deck
		#determine random card
		d_card_nbr = rand(1..$deck.length-1) # s/b 1 to 52
		#assign card
		deal_card = $deck[d_card_nbr]
		#puts "Dealt " + $deck[d_card_nbr]
		#remove card from deck
		$deck.delete ($deck[d_card_nbr])
	end
end
class Hand

end

def deal_hand #deal out initial cards
	for x in 1..$players.length-1
		$players [x].card1 = Card.new($d.deal_card)
		$players [x].card2 = Card.new($d.deal_card)
	end	
end

def flop
	$flop = []
	$flop[1] = Card.new($d.deal_card)
	$flop[2] = Card.new($d.deal_card)
	$flop[3] = Card.new($d.deal_card)
	$flop[4] = Card.new($d.deal_card)
	$flop[5] = Card.new($d.deal_card)
end


