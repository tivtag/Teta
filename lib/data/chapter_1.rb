
location :long_road do

  name 'Long Road V'
  desc 'A straight road. As you gaze into the north you can make out a
        [station]. A [paper stack] lies below you.'  

  remote_location :station

  location :paper_stack do
    desc 'A stack of various pre-war magazines.
          [Search]ing the stack might be a good idea.'

    item :old_coin
    action :search do
       take :old_coin
       desc "A mixed up stack of magazines."
    end
  end
 	
end

location :station do
  name 'Station Charly'
  desc 'A deserted ...'
end
