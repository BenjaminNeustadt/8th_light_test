require_relative '../lib/bookdata'

RSpec.describe BookData do

  before :each do
    @isolated_list = BookSearch.new('history', offline: true)
    @test_book_data = JSON.parse(File.read('test_data.json'))
  end

  context "connection" do
    it "reads data from the test file" do
      bookdata = BookData.new('history', offline: true)
      expected = @test_book_data
      actual = bookdata.data_query
      expect(actual).to eq(expected)
    end
  end

end


