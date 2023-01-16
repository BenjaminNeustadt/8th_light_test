require_relative '../lib/bookview'

RSpec.describe BookView do

  context 'initialize' do

    it 'instantiates an instance of BookStorage' do
      bookview = BookView.new
      expect(bookview.storage).to eq []
    end

  end

end
