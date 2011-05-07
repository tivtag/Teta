
location :road do

  desc "June 27 1926 - 11 P.M. Rainy summer night.
        At this strange night not even the moon dares to show itself - only half-diffunct street lights are trying to illuminate the chuckholed country road.
       
        Why are you here at this time? To find answers. To find out why they had to die. As you gaze into far distance your hope of finding what you seek comes nearer.
        The old [manor] once was owned by your grand-grand parents. You hoped to renovate it after it stood empty for atleast two generations.
        If you just had known that peculiar reasons earlier.."
   
   on_enter do
     music 'rain'
     block

     give_new_item :key, 'A large rusty key. It mimics a snake head.'
   end

   remote_location :manor do
     transition do
        desc 'You approach the manor with haste as the rain is getting stronger. You must find shelter soon.'
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
