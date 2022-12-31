module Reportable


# :TODO: extract from here
  OFFLINE = true

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


  LIST_ITEM =
    <<~EOS
      -----------------------
      Book number %<index>s
      title: %<title>s
      author: %<authors>s
      publisher: %<publisher>s
      -----------------------
      EOS


	LINE_STYLE = {
		default: '=======================',
		special: '+=+=+=+=+=+=+=+=+=+=+=+'
	}

	REPORT =
    <<~REPORT
      %<title>15s
      %<border>s
      %<booklist>s
      %<border>s
    REPORT

end
