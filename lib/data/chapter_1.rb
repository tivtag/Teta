
location :kitchen do
  
  desc 'A fading [fire] is illuminating the room. Wads of smoke are originating from the fire sink.
        The kitchen [floor] is made of strangely decorated marble plates.
        You can hear water slowly trickeling from the [water] dispenser.'  

  remote_location :station

  location :floor do
    desc "Some of the marble plates picture some-thing- that you can't.. really describe.
          It is a gruesome.. fish.. with tentacles.. and...
          You have to force yourself to lift your view. The rest of the floor looks rather blank.
          In one of the corners lies an empty loam [bottle]."

    item :bottle

    action :take do |item|
      if take item.intern then
        remove_last_sentence
      else
        unknown
      end
    end
  end

  location :fire do
    desc 'The thick smoke burns in your eyes. As you inspect the fire sink you manage to
          catch a glimpse of something shiny! Try to [take] it?'

    item :gold_coin
    action :take do
       if itis :safe then take :gold_coin else puts 'Aah! Autsch! That hurt!' end
    end

    action :put do |item|
   
      if remove_player_item item, :water then
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
