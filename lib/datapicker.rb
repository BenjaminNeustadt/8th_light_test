require_relative './strategy/testdata'
require_relative './strategy/bookdata'

module DataPicker

  SOURCE = ENV['API_KEY'] ? proc {|choice| BookData.new(choice).parse } : proc { TestData.new.parse }

end
