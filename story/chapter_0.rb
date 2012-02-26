
location :road do
  desc "June 27 1892 - 11 P.M.
    On this strange night, not even the [moon] dares show its face, the only illumination on the scarred and bumpy country road comes
    from the flickering street [lights] scattered inconsistently along its length.

    Why are you here at this time? To find answers. To find out why they had to die. You feel more at ease as you gaze into the distance, where the [manor] of your great-grandparents just came into view.
    While your parents and grand parents had left it empty and declining, you had hoped to renovate it after coming into your inheritance.
    Had you known their reasons for doing so earlier, you may not have been quite so eager."
   
   on_enter do
     music 'rain'
     block

     give_new_item :key, 'A large rusty key. It mimics a snake head. You found it in your mail box just a week before this queer story started.'
     give_new_item :electrictorch, 'Your trustworthy light source.'
   end

   poi :moon, 'You look around, straining to make out the moon behind the thick clouds overhead. Nothing.'
   poi :lights, 'Electrical street lights. New, yet already flagging. Electricity is probably a rather new concept to the locals.'
   poi :manor, 'The old manor, still tiny in the distance, something inside you seems to be urging you towards it.'

   remote_location :manor do
     transition do
        desc 'You increase your pace as you approach the manor, the rain is getting heavier. You should find shelther soon.'
     end	
   end
end

location :manor do
  desc 'Weather-beaten stone [walls] clad in ivy surround the old wooden building.
        The only entrance to the yard seems to be the old and rusty iron [gate].'

  poi :walls, 'It is said that the walls were built long before the manor itself, perhaps the remnants of some old castle.'
  poi :gate, 'Strong impenetrable iron. You should take a closer look.'
  on_enter { block }

  location :gate do
     desc "A large [lock] decorated with snakes holds the [gate] shut.
           Haven't you got this [key] in your pocket?"

     poi :lock, 'It looks too new to be part of the original gate. Will your key still work?'

     action :use do |item|
       if remove_player item, :key then
         set :unlocked
         puts 'The key unlocks the gate.'
         desc 'The gate is now unlocked. You hesitate for a moment, wondering if you should dare to open it.'
       else
         unknown
       end
     end

     action :take do |item|
        if itis :unlocked and item == :key then
          puts "As you try to retrieve the key, it sticks and snaps in two. At least it didn't break before you unlocked the gate!"
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
            puts 'You close the gate to the manion. You feel the urge to leave. Must it be really *you* that has to set things into place again?'

            lock_location :garden
            unlock_location :home
          else
            puts "No! You can't just close a gate twice."
          end
        else
          unknown
        end
     end

     location :garden do
       blocked

       on_enter do
         puts 'Soaked to the bone, you finally enter the manor grounds. As you stop to catch your breath and observe your surroundings, you hear a loud *creaking* noise. 
               You turn around to see the gate closed behind you. At least now you are past making decissions, you can only go forward from here.'
         change_to_chapter 1 
       end
     end

     location :home do
       blocked

       on_enter do
         puts 'Certain of leaving this place, an unearthly terror takes hold of you and you flee back the way you came.
               Something is following, and no matter how far you push yourself, it is gaining on you. Breath.. In your haste you stumble, falling face first *SPLASH!* in a pool of muddy water.'

         puts "A shadowy figure speaks: 'This is a place of no return. Now choose wisely."
         choice "Will you [come] or [leave]?'",
            come:-> {
              puts "'Wise..'. Unable to act, you become weaker until you faint. You don't know what has happened until.."
              puts ".. you wake up again.. inside the manor.. the garden.. you stand up, shake and steady yourself. This won't be easy. You take a closer look of the garden."

              give_new_item :ectoplasm, 'Eeehgh. Sticky.'
              change_to_chapter 1 
            },
            other:-> {
              puts "'Then rest in peace and.. pieces! A-haha!'"
              die
            }
       end
     end
  end
end

