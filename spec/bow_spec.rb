# Your code here
require './lib/weapons/bow.rb'

describe Bow do

  let(:bow){ Bow.new }

  describe '#initialize' do
    it 'has 10 arrows by default' do
      expect(bow.arrows).to eq(10)
    end
    it 'created with a specified number of arrows' do
      new_bow = Bow.new(100)
      expect(new_bow.arrows).to eq(100)
    end
  end
  describe '#use' do
    it 'reduce the arrows by 1 when used once' do
      bow.use
      expect(bow.arrows).to eq(9)
      bow.use
      expect(bow.arrows).to eq(8)
    end
    it 'throw an error when used with 0 arrow' do
      10.times { bow.use }
      expect(bow.arrows).to eq(0)
      expect{ bow.use }.to raise_error
    end
  end

end
