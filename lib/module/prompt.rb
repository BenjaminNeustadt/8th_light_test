module Prompt

  MENU = {
    ACTION: {
      1 => "search",
      2 => "view search results",
      3 => "add",
      4 => "view",
      0 => "exit"
    }
  }

  ACTION_PROMPT = "%<option>s) %<action>s\n"

  def menu
    MENU[:ACTION].each_with_object("") do |(option, action), menu|
      menu << ACTION_PROMPT % {option: option, action: action}
    end
  end

end
