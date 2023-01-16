require_relative '../lib/bookview'

RSpec.describe BookView do

  context 'initialize' do
    it 'instantiates an instance of BookStorage' do
      bookview = BookView.new
      expect(bookview.storage).to eq []
    end

    it 'instantiates with an empty search results' do
      bookview = BookView.new
      expect(bookview.search_results).to eq []
    end
  end

  context 'menu' do
    it 'shows the game menu' do
      bookview = BookView.new
      expected =
        <<~MENU
        1) search
        2) view search results
        3) add
        4) view
        0) exit
        MENU

      expect(bookview.menu).to eq expected
    end
  end

end
