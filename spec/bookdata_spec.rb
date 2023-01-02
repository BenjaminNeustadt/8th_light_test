require_relative '../lib/bookdata'

RSpec.describe BookData do

  before :each do
    @test_book_data = JSON.parse(File.read('test_data.json'))
  end

  context "connection" do
    it "reads data from the test file" do
      books = BookData.new('history')
      expected = @test_book_data
      actual = books.data
      expect(actual).to eq(expected)
    end
  end

end


