load "RubyClassModule.rb" #Player, Card class; LoadDeck Module
load "RubyCardsHands.rb"
include DetermineHandValue
# puts $deck [0]
#Enter Number of Players - totplayers var
#Enter your name - P1name
P1name = "Enzo"
PLAYERNAMES = ["Jess", "Dante", "Lucia", "Marcos", "John", "Suzie"]
$totplayers = 4
$players = []

#PLAYER 1
$players.push 1
$players [1] = Player.new(P1name, 1000)
# $players [1].name = P1name 
# $players [1].bank = 1000 

#COMPUTER PLAYERS
for x in 2..$totplayers
	$players.push x
	$players [x] = Player.new(PLAYERNAMES[x], 1000)
	# $players [x].name = 
	# $players [x].bank = 1000
end

$d = Deck.new
$d.load

deal_hand()
puts "Player #{1.to_s} (#{$players[1].name}) cards:" + $players [1].card1.display + " " + $players [1].card2.display

flop()
puts $flop[1].display + $flop[2].display + $flop[3].display + $flop[4].display + $flop[5].display 
hand_value($players[1].card1, $players[1].card2, $flop[1], $flop[2], $flop[3], $flop[4], $flop[5])
