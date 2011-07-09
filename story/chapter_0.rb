
location :road do

  desc "June 27 1926 - 11 P.M.
        At this strange night not even the [moon] dares to show itself - only half-diffunct street [lights] are trying to illuminate the chuckholed country road.
       
        Why are you here at this time? To find answers. To find out why they had to die. As you gaze into the distance you feel more at ease with yourself.
        It's the old [manor] of your great-grandparent which just became distinguishable. You hoped to renovate it after it stood empty for atleast two generations.
        If you just had known that peculiar reasons earlier.."
   
   on_enter do
     music 'rain'
     block

     give_new_item :key, 'A large rusty key. It mimics a snake head.'
   end

   poi :moon, "As hard as you look around - you still don't manage to locate the moon on the sky. Where is it hiding? Hopefully behind those thick cloud layers."
   poi :lights, "Electrical Street Lights. New, yet already damaged. Electricity is a pretty new concept for the common folk."

   remote_location :manor do
     transition do
        desc 'You approach the manor with haste as the rain is getting stronger. You must find shelter soon.'
     end	
   end
end

location :manor do

  desc 'Large ivy-glad stone [walls] are surrounding the old wooden building.
        The only viable way to get into the inner-ring of the manor is the large iron [gate].' 

  poi :walls, 'It is said that those walls were build even earlier than the manor itself.'

  on_enter { block }

  location :gate do
     desc "A large with snakes decorated [lock] is preventing you from [open]ing the [gate].
           Havn't you gotten this [key] in your pockets?"

     action :use do |item|
       if remove_player item, :key then
         set :unlocked
         puts 'The key unlocks the gate.'
         desc 'The gate to the manor is unlocked. Should you really dare to [open] it?'
       else
         unknown
       end
     end

     action :take do |item|
        if item.to_sym  == :key then
          puts "As hard as you try.. the key won't move. It snapped."
        else
          unknown
        end   
     end

     action :open do |obj|
       if obj == 'gate' then
         if itis :unlocked then
           if itisnt :open then
             set :open
             puts 'The pathway to the [garden] opens.'

             unlock_location :garden
           else
             puts 'Silly! The gate is already open.'
           end
         else
           puts 'A lock is preventing you from opening it.'
         end
       else
         unknown
       end
     end

     action :close do |obj|
        if obj == 'gate' then
          if itis :open then
            unset :open
            puts 'You close the gate to the family manion. Do you give up?'

            lock_location :garden
            unlock_location :home
          else
            puts "You can't just close a gate twice."
          end
        else
          unknown
        end
     end

     location :garden do
       blocked

       on_enter do
         change_to_chapter 1
       end
     end

     location :home do
       blocked

       on_enter do
         puts 'You flee from the manor. Yet a shadow is lurking behind you even closer. You are out of breath. And must stop.'
         puts "The shadow speaks: 'This is a place of no return. Don't attempt to flee your destiny in your next life. Rest in Peace.'"

         die
       end
     end
  end

end
