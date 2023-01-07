require_relative './decorators'

module Report

  include Decorators

  ITEM =
    <<~EOS
      -----------------------
      Book number %<index>s
      title: %<title>s
      author: %<authors>s
      publisher: %<publisher>s
      -----------------------
      EOS

	REPORT =
    <<~REPORT
      %<title>15s
      %<border>s
      %<booklist>s
      %<border>s
    REPORT

  def item(book, index)
    ITEM % {
      index:     index,
      title:     book[:title],
      authors:   book[:authors],
      publisher: book[:publisher]
    }
  end


  def report_retrieved_books
    "AVAILABLE BOOKS:\n" << @search_results
      .each.with_index(1)
      .with_object("") do |(book, index), report|
      report << item(book, index)
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

	def report_booklist(line_style)
    @users_storage
      .container.each.with_index(1)
      .with_object(booklist = "") do |(book, index)|
        booklist << item(book, index)
      end

    REPORT % {booklist: booklist, border: line_style , title: 'BOOKLIST'}
  end

  def report_total_number_books_added
    <<~EOS % @users_storage.container.size
    =======================
      Total books in user list: %i
    =======================
      EOS
  end

end

