def cdisplay(cvalue)
	case cvalue.chars.first(2).join
	when "11"
		cvalue = "J" + cvalue.chars.last(1).join
	when "12"
		cvalue = "Q" + cvalue.chars.last(1).join
	when "13"
		cvalue = "K" + cvalue.chars.last(1).join
	when "14"
		cvalue = "A" + cvalue.chars.last(1).join
	end
	case cvalue.chars.last(1).join 
	when "S"
		cdisplay = cvalue.chars.first(1).join + "\u2660".encode('utf-8')
	when "D"
		cdisplay = cvalue.chars.first(1).join + "\u2666".encode('utf-8')
	when "C"
		cdisplay = cvalue.chars.first(1).join + "\u2663".encode('utf-8')
	when "H"
		cdisplay = cvalue.chars.first(1).join + "\u2665".encode('utf-8')
	end
end