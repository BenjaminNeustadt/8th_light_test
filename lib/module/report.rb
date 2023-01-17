module Report

  REPORT =
    <<~REPORT
  %<title>15s
  %<border>s
  %<booklist>s
  %<border>s
  REPORT

  ITEM =
    <<~EOS
      -----------------------
      Book number %<index>s
      title: %<title>s
      author: %<authors>s
      publisher: %<publisher>s
      -----------------------
  EOS

  def item(book, index)
    ITEM % {
      index: index,
      title: book[:title],
      authors: book[:authors],
      publisher: book[:publisher]
    }
  end

  def report_books_added
    list = []
    @users_storage.container.each do |book|
      list << "- #{book[:title]}"
    end
    "You added %<number_of>i books:\n%<list>s" %
      {number_of: list.size, list: list.join("\n")}
  end

end
