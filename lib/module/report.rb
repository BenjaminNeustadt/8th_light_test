module Report

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

end
