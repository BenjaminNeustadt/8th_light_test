class TestData

  def initialize
    @parse = JSON.parse(File.read('test_data.json'))
  end

  attr_reader :parse

end

