
module DSL
  module Choices

  def choice(text, actions)
    println text
    input = read_input.to_sym

    action = actions[input]
    
    if action.nil? then
      action = actions[:other]
      
      if action.nil? then
        unknown
      else
        if action.arity == 0 then
          action.call
        else
          action.call input
        end
      end
    else
      action.call 
    end
  end

  end
end

