
location :kitchen do
  
  desc 'A fading [fire] is illuminating the room. Wads of smoke are originating from the fire sink.
        The kitchen [floor] is made of strangely decorated marble plates.
        You can hear water slowly trickeling from the water [dispenser].'  

  remote_location :station

  location :floor do
    desc "Some of the marble plates picture some-thing- that you can't.. really describe.
          It is a gruesome.. fish.. with tentacles.. and...
          You have to force yourself to lift your view. The rest of the floor looks rather blank.
          In one of the corners lies an empty loam [bottle]."

    item :bottle, 'A loam bottle. It is slightly damaged.'

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
    desc 'The thick smoke burns in your eyes. As you inspect the fire sink you manage to
          catch a glimpse of something shiny! Try to [take] it?'

    item :gold_coin, 'Very shiny! Must be worth a ton.'

    action :take do
       if itis :safe then take :gold_coin else puts 'Aah! Autsch! That hurt!' end
    end

    action :use do |item|
   
      if remove_player item, :water then
        set :safe
        puts 'You extinguish the flame using the water.'
      else
        unknown
      end

    end
  end
 	
end

location :station do
  name 'Station Charly'
  desc 'A deserted ...'
end
