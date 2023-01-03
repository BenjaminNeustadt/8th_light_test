require_relative '../lib/bookstorage'

RSpec.describe BookStorage do

  it 'contains an empty Array upon instantiation' do
    storage = BookStorage.new
    expect(storage.container).to be_a Array
    expect(storage.container).to eq []
  end

  it 'can have data inserted' do
    storage = BookStorage.new
    chosen_book = {author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}
    storage.container << chosen_book
    expect(storage.container).to eq [{author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}]
  end

end

