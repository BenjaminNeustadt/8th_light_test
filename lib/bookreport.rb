module Formatter

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

  def menu
    MENU[:ACTION].each_with_object("") do |(option, action), menu|
      menu << ACTION_PROMPT % {option: option, action: action}
    end
  end

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

# :TODO: methods for reporting to user
# These should probably be extracted to a Report class

	REPORT =
    <<~REPORT
      %<title>15s
      %<border>s
      %<booklist>s
      %<border>s
    REPORT

  def report_retrieved_books
    "AVAILABLE BOOKS:\n" << @search_results
      .each.with_index(1)
      .with_object("") do |(book, index), report|
      report << list_item(book, index)
    end
  end

  def report_books_added
    list = []
    @users_storage.container.each do |book|
      list << "- #{book[:title]}"
    end

    plural = list.size == 1 ? "" : "s"

    "You added %<size>i book%<plural>s:\n%<list>s" %
      {size: list.size, plural: plural, list:list.join("\n")}
  end

	def report_booklist
    @users_storage
      .container.each.with_index(1)
      .with_object(booklist = "") do |(book, index)|
        booklist << list_item(book, index)
      end

    REPORT % {booklist: booklist, border: LINE_STYLE[:special], title: 'BOOKLIST'}
  end

  def list_item(book, index)
    LIST_ITEM % {
      index:     index,
      title:     book[:title],
      authors:   book[:authors],
      publisher: book[:publisher]
    }
  end

  def report_total_number_books_added
    <<~EOS % @users_storage.container.size
    =======================
      Total books in user list: %i
    =======================
      EOS
  end

end

