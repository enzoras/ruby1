#LATEST
#TWO PAIR HIGH CARD??
#3KIND HIGH CARDs
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
	 	@str_count=0; @flush_suit = ""; @flush_arr = []
	 	card_count = Hash.new(0) #array to count like cards, e.g. pairs, 3kind, etc
	 	c1.each do |x| #KEY CHECK FOR ALL HANDS
		 	card_count[x.nbr] +=1
		 	case x.suit 
		 		when "DIAMOND"
		 	 		d.push x.nbr
		 	 		if d.length >=5 then @flush_arr = d end
		 		when "SPADE"
		 			s.push x.nbr
		 			if d.length >=5 then @flush_arr = s end
		 		when "CLUB"
		 			c.push x.nbr
		 			if d.length >=5 then @flush_arr = c end
		 		when "HEART"
		 			h.push x.nbr
		 			if d.length >=5 then @flush_arr = h end
		 	end
		end
	#FLUSH / STRAIGHT FLUSH CHECK
		if @flush_arr.length >=5  
			@flush_arr.sort!.reverse!
			if check_straight (@flush_arr)
			 	#STRAIGHT FLUSH
				@hand_value = 80000 + @str_count*100
			else
				#FLUSH
				@hand_value = [50000 + d[0]*500+500 + d[1]*50+50 + d[2]*5+5 + d[3].to_f*0.5+0.5 + d[4].to_f*0.05+0.05, @hand_value].max   	
			end
		end
	#CHECK MULTIPLES	
		check_multiples(card_count)
	#CHECK STRAIGHT
		check_straight(card_count)

		case @hand_value
			when 80000..90000
				puts "STRAIGHT FLUSH"
			when 70000..80000
				puts "4 OF A KIND " + (@handvalue - 70000)/100 + "!!"
			when 60000..70000
				puts "FULL HOUSE" + nbr_display(@three_kind_nbr) + "OVER" + nbr_display(@pair.max)
			when 50000..60000
				puts "FLUSH TO THE " + nbr_display(@flush_arr[0])
			when 40000..50000
				puts "STRAIGHT TO THE " + nbr_display(@str_count)
			when 30000..40000
				puts "3 of a kind " + nbr_display(@three_kind_nbr)
			when 20000..30000
				puts "2 PAIR " + nbr_display(@pair[0]) + " AND " + nbr_display(@pair[1])
			when 10000..20000
				puts "PAIR OF " + nbr_display(@pair[0])
			when 0..10000
				puts "HIGH CARD" #SET HAND_VALUE AND PUTS MSG
		end				
				
		puts "HAND VALUE:"
		p @hand_value.to_f
	end

	def check_multiples(c1)		#PAIRS, 3KIND, 4KIND		
		c1.sort.reverse.each do |k,v|
			case v
				when 4
					@four_kind_count = 1
					@hand_value = [70000 + (k*100), @hand_value].max
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
		end
		if @hand_value <20000 and @pair_count >=2 #2 PAIR
			@hand_value = [20000 + @pair[0]*100 + @pair[1], @hand_value].max
		end
		if @hand_value <20000 and @three_kind_count == 1 and @pair_count ==0 #3 of a kind
			@hand_value = [30000 + (@three_kind_nbr*100), @hand_value].max
		end
		if @three_kind_count == 1 and @pair_count >=1 #FULL HOUSE
			@hand_value = [@hand_value, (60000 + @three_kind_nbr*100 + @pair.max)].max
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
			check_straight = true	
			@hand_value = 40000 + @str_count*100
		else
			check_straight = false
		end
	end
end

	# def check_flush(*c1)	#FLUSH CHECK
	# 	if [d.length,s.length,c.length,h.length].max >= 5
	# 		if d.length ==5 
	# 			flush_suit = "DIAMOND" 
	# 			flush_arr = d
	# 			# d.sort!.reverse!
	# 			high_card = d[0]
	# 			@hand_value = [50000 + d[0]*500+500 + d[1]*50+50 + d[2]*5+5 + d[3].to_f*0.5+0.5 + d[4].to_f*0.05+0.05, @hand_value].max   
	# 		end
	# 		if s.length ==5
	# 			flush_suit = "SPADE"
	# 			s.sort!reverse!
	# 			high_card = s[0]
	# 			@hand_value = [50000 + s[0]*500+500 + s[1]*50+50 + s[2]*5+5 + s[3].to_f*0.5+0.5 + s[4].to_f*0.05+0.05, @hand_value].max   	
	# 		end

	# 		if c.length ==5
	# 			flush_suit = "CLUB"
	# 			c.sort!.reverse!
	# 			high_card = c[0]
	# 			@hand_value = [50000 + c[0]*500+500 + c[1]*50+50 + c[2]*5+5 + c[3].to_f*0.5+0.5 + c[4].to_f*0.05+0.05, @hand_value].max   	
	# 		end

	# 		if h.length ==5
	# 			flush_suit = "HEART"
	# 			h.sort!.reverse!
	# 			high_card = h[0]
	# 			@hand_value = [50000 + h[0]*500+500 + h[1]*50+50 + h[2]*5+5 + h[3].to_f*0.5+0.5 + h[4].to_f*0.05+0.05, @hand_value].max   	
	# 		end
	# 	puts "FLUSH " + flush_suit + " TO THE " + nbr_display(high_card)
	# 	end
			
	# end