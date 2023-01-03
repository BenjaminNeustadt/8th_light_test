require 'json'

class TestData

  def initialize
    @parse = JSON.parse(File.read('spec/test_data.json'))
  end

  attr_reader :parse

end

