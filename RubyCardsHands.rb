#LATEST
#CODE CLEANUP - WORK ON FLUSH

#TWO PAIR HIGH CARD??
#3KIND HIGH CARDs
#STRAIGHT FLUSH
module DetermineHandValue
		# def hand_value(c1, c2, c3, c4, c5, c6, c7) #determine poker hand; pass cards as object
	def nbr_display (value) #Display number e.g. 2, KING, ACE, etc
		case value
			when 14
				nbr_display = "ACE" #A = 14
			when 13
				nbr_display = "KING"
			when 12
				nbr_display = "QUEEN"
			when 11
				nbr_display = "JACK"
			else	
				nbr_display = value.to_s
		end
	end

	def hand_value(*c1) #determine poker hand; pass cards as object
		@hand_value = 0
	 	d=[]; s=[];c=[];h=[]; high_card=0 #SUIT ARRAYS FOR FLUSHES
	 	@three_kind_nbr = 0; @three_kind_count = 0;@pair_count = 0; @four_kind_count=0; @pair = []
	 	@str_count=0
	 	card_count = Hash.new(0) #array to count like cards, e.g. pairs, 3kind, etc
	 	c1.each do |x|
		 	card_count[x.nbr] +=1
		 	case x.suit 
		 		when "DIAMOND"
		 	 		d.push x.nbr
		 		when "SPADE"
		 			s.push x.nbr
		 		when "CLUB"
		 			c.push x.nbr
		 		when "HEART"
		 			h.push x.nbr
		 	end
		end
		
		check_multiples(card_count)
		check_straight(card_count)
		# check_flush(*c1)

		puts "HAND VALUE:"
		puts @hand_value.to_f
		#STR FLUSH = 8
		#4KIND = 7
		#FULL HOUSE = 6
		#FLUSH = 5
		#STRAIGHT = 4
		#3KIND 3
		#2PAIR 2
		#PAIR 1
		#HIGH HARD 0
	end
	def check_flush(*c1)	#FLUSH CHECK
	 	#d=0; s=0;c=0;h=0
		if [d.length,s.length,c.length,h.length].max >= 5
			if d.length ==5 
				flush_suit = "DIAMOND" 
				d.sort!.reverse!
				high_card = d[0]
				@hand_value = [50000 + d[0]*500+500 + d[1]*50+50 + d[2]*5+5 + d[3].to_f*0.5+0.5 + d[4].to_f*0.05+0.05, @hand_value].max   
			end
			if s.length ==5
				flush_suit = "SPADE"
				s.sort!everse!
				high_card = s[0]
				@hand_value = [50000 + s[0]*500+500 + s[1]*50+50 + s[2]*5+5 + s[3].to_f*0.5+0.5 + s[4].to_f*0.05+0.05, @hand_value].max   	
			end

			if c.length ==5
				flush_suit = "CLUB"
				c.sort!.reverse!
				high_card = c[0]
				@hand_value = [50000 + c[0]*500+500 + c[1]*50+50 + c[2]*5+5 + c[3].to_f*0.5+0.5 + c[4].to_f*0.05+0.05, @hand_value].max   	
			end

			if h.length ==5
				flush_suit = "HEART"
				h.sort!.reverse!
				high_card = h[0]
				@hand_value = [50000 + h[0]*500+500 + h[1]*50+50 + h[2]*5+5 + h[3].to_f*0.5+0.5 + h[4].to_f*0.05+0.05, @hand_value].max   	
			end
		puts "FLUSH " + flush_suit + " TO THE " + nbr_display(high_card)
		end
			
	end
	def check_multiples(c1)		#PAIRS, 3KIND, 4KIND		
		c1.sort.reverse.each do |k,v|
			case v
				when 4
					@four_kind_count = 1
					@hand_value = [70000 + (k*100), @hand_value].max
					puts "4 " + nbr_display(k) + "!!"
					exit
				when 3
					@three_kind_count = 1
					@three_kind_nbr = [@three_kind_nbr, k].max
				when 2
					case @pair_count
						when 0 #first pair
							@pair[0] = k
							@pair_count +=1
						when 1 #2nd pair
							@pair[1] = k
							@pair_count +=1
						when 2 #3rd pair 
							@pair[2] = k
							@pair_count +=1
					end
					@pair.sort!.reverse!
			end
		end

		if @hand_value <20000 and @pair_count==1  #ONE PAIR
			@hand_value = [10000  + @pair[0]*100, @hand_value].max	
			puts hand_value = "PAIR OF " + nbr_display(@pair[0])
		end
		if @hand_value <20000 and @pair_count >=2 #2 PAIR
			@hand_value = [20000 + @pair[0]*100 + @pair[1], @hand_value].max
			puts "2 PAIR " + nbr_display(@pair[0]) + " AND " + nbr_display(@pair[1])
		end
		if @hand_value <20000 and @three_kind_count == 1 and @pair_count ==0 #3 of a kind
			@hand_value = [30000 + (@three_kind_nbr*100), @hand_value].max
			puts "3 of a kind " + nbr_display(@three_kind_nbr)
		end
		if @three_kind_count == 1 and @pair_count >=1 #FULL HOUSE
			@hand_value = [@hand_value, (60000 + @three_kind_nbr*100 + @pair.max)].max
			puts "FULL HOUSE" + nbr_display(@three_kind_nbr) + "OVER" + nbr_display(@pair.max)
		end
	end
	def check_straight(c1)		#STRAIGHT CHECK
	 	nbr_arr = [] #use for the straight
	 	c1.sort.reverse.each do |k,v|
	 	 	nbr_arr.push k
		end
		if nbr_arr.length >=5 and nbr_arr[0]==13 and nbr_arr[6]==2 and nbr_arr[5]==3 \
			and nbr_arr[4]==4 and nbr_arr[3]==5 
			@str_count = 5 #LOWEST STRAIGHT
		end
		if nbr_arr.length ==7 and nbr_arr[2]==nbr_arr[3]+1 and nbr_arr[3]==nbr_arr[4]+1 and nbr_arr[4]==nbr_arr[5]+1 \
			and nbr_arr[5]==nbr_arr[6]+1
			@str_count = nbr_arr[2]
		end
		if nbr_arr.length >=6 and nbr_arr[1]==nbr_arr[2]+1 and nbr_arr[2]==nbr_arr[3]+1 and nbr_arr[3]==nbr_arr[4]+1 \
			and nbr_arr[4]==nbr_arr[5]+1
			@str_count = nbr_arr[1]
		end
		if nbr_arr.length >=5 and nbr_arr[0]==nbr_arr[1]+1 and nbr_arr[1]==nbr_arr[2]+1 and nbr_arr[2]==nbr_arr[3]+1 \
			and nbr_arr[3]==nbr_arr[4]+1 
			@str_count = nbr_arr[0]
		end
		if @str_count >0
			puts "STRAIGHT TO THE " + nbr_display(str_count)
			@hand_value = 40000 + @str_count*100
		end
	end
end

