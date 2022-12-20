
class BookStorage

  private

  def initialize
    @users_list = []
  end

  public

  attr_reader :users_list

  def add(book_data)
    users_list << book_data
  end

end
