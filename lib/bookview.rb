require_relative './bookstorage'

class BookView

  def initialize
    @storage = BookStorage.new.container
  end

  attr_reader :storage

end
