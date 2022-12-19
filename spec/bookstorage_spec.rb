require_relative '../lib/bookstorage'

RSpec.describe BookStorage do

  it 'must contain an empty Array upon instantiation' do
    storage = BookStorage.new
    expect(storage.users_list).to be_a Array
    expect(storage.users_list).to eq []
  end

  it 'can have data inserted' do
    storage = BookStorage.new
    chosen_book = {author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}
    storage.users_list << chosen_book
    expect(storage.users_list).to eq [{author: 'Benjamin', title:'Notes As We Go', publisher: 'Keeper of the Phones'}]
  end

end

