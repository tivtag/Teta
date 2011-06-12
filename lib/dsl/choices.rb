
module DSL
  module Choices

  def choice(text, actions)
    puts text
    input = read_input.to_sym

    action = actions[input]
    
    if action.nil? then
      action = actions[:other]
    end

    if action.nil? then
      unknown
    else
      if action.arity == 0 then
        action.call
      else
        action.call input
      end
    end
  end

  end
end

