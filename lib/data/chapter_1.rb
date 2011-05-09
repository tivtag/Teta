
location :garden do
  desc "The garden looks strangely well cultivated. Yet you havn't ordered anyone..
        Black and red [roses] are blooming."

  item :roses

  remote_location :manor do
    transition do
      desc "You follow the earthy walkway to the entrance of the manor."
    end
  end

  remote_location :gate

  action :take do |item|
    take item.to_sym
  end
end

location :gate do
  desc "The gate is closed. You can see a toggle [switch]."
 
  remote_location :garden
  remote_location :manor

  action :open do
    puts "As hard as you try.. the gate won't open. You're trapped."
  end

  action :use do |obj|
    if obj == 'switch' then
      puts 'As you pull the toggle switch down the once solid wooden floor below you opens and pulls you down.'
    
      choice 'What was your next action? Quickly [jump] away? Attempt to [hold] at the edge? Or [nothing]?', 
      jump:-> { 
        puts "The jump was not successful."
        die 
      },
      hold:-> {
        puts "Phew. That was close. After you've pulled yourself up the wood plate
             moved back to its original position. You might not want to pull the switch again."
      },
      nothing:-> { 
        puts "You fall to your death!"
        die
      },
      other:-> {
        puts 'Uhuh.. no.. just no.'
        die
      }
    else
      unknown
    end
  end
end

location :manor do
  desc "The family manor - they say that there are secrets in
        this house that should not be uncovered ever again.   

        The well-sized [foyer] is infront of you."

  on_enter do
     music 'rain'
  end

  remote_location :foyer do
    transition do
      on_enter do
        music 'night'
      end
    end
  end
end

location :foyer do
  desc "From the foyer various tight paths lead to the rooms of the manor.
        Old unlit [candle]-lights are placed next to the walls. Strange."

  action :take do |item|
    if item == 'candle' then
      puts "An inner shouder flows through your body as you approach one of the candles.
            No - you can't bring yourself to do it."
    else
      unknown
    end
  end

  remote_location :kitchen
end

location :kitchen do
  
  desc 'A fading [fire] is illuminating the room. Wads of smoke are originating from the fire sink.
        The kitchen [floor] is made of strangely decorated marble plates.
        You can hear water slowly trickeling from a water [dispenser].'  

  remote_location :store_room

  location :floor do
    desc "Some of the marble plates picture some-thing- that you can't.. really describe.
          It is a gruesome.. fish.. with tentacles.. and...
          You have to force yourself to lift your view. The rest of the floor looks rather blank.
          In one of the corners lies an empty loam [bottle]."

    item :bottle, 'A loam bottle. Slightly damaged.'

    action :take do |item|
      if take item then
        remove_last_sentence
      else
        unknown
      end
    end
  end

  location :dispenser do
    desc 'Water is steadily dropping from the iron-glad dispenser. This would keep you awake at night. Very annoying.'
    item :water, 'A water-filled loam bottle.'

    action :use do |item|
      if remove_player item, :bottle then
        take :water
      else
        unknown
      end
    end
  end

  location :fire do
    desc 'Thick smoke burns in your eyes. As you inspect the fire sink you manage to
          catch a glimpse of something shiny! Try to [take] it?'

    item :gold_coin, '24K gold coin. Tentacles are inprinted on both sides. Disturbing!'

    action :take do
      if itis :safe then 
         take :gold_coin
         unset :safe
         desc 'The fire in the sink has re-ignited. Too hot!'
      else 
         puts 'Aah! Autsch! That hurt!'
      end
    end

    action :use do |item|
   
      if remove_player item, :water then
        set :safe
        puts 'You extinguish the flame using the water.'
        desc 'The smoke still burns in your eyes. But it should now be safe to [take] the shiny object.'
      else
        unknown
      end

    end
  end
 	
end

location :store_room do
  desc 'A deserted room.'
end
