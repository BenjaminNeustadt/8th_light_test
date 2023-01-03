require_relative '../lib/strategy/testdata'

RSpec.describe TestData do

  context "parse" do
    it "returns dummy data upon initialize" do

      expected = JSON.parse(File.read('spec/test_data.json'))

      data     = TestData.new
      actual   = data.parse
      expect(actual).to eq(expected)
    end
  end

end
