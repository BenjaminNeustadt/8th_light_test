
class BookStorage

  private

  def initialize
    @container = []
  end

  public

  attr_reader :container

  def add(book_data)
    container << book_data
  end

end
