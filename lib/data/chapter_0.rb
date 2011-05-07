
location :road do

  desc "March 27 1926 - 11 P.M. A rainy autumn night.
        
        You feel so alone.. You've lost friends, your family..
	It must have.. or.. was.. it..?

	You don't have time to waste. There must be clues at the family [manor]."

   transition { blocked }

   remote_location :manor do
     transition do
        desc 'You approach with haste as the rain is getting stronger. You must find shelter soon.'
     end	
   end
end

location :manor do

  desc 'Large ivy-glad stone walls are surrounding the old wooden building.
        The only viable way to get into the inner-ring of the manor is the large iron [gate].' 
	
  location :gate do
     desc "A large with snakes decorated [lock] is preventing you from opening the gate.
           Havn't you gotten this [key] in your pockets?"
  end

end
