require 'warmup.rb'

describe Warmup do

  let(:new_instance){ Warmup.new }

  describe '#gets_shout' do
    it 'shout return uper case' do
      expect(new_instance).to receive(:gets).and_return("hello world")
      new_instance.gets_shout
    end
  end
  describe '#triple_size' do
    it 'triple the size of a number' do
      my_array = instance_double("Array", size: 3)
      expect(new_instance.triple_size(my_array)).to eq(9)
    end
  end
  describe '#calls_some_methods' do
    it 'the string passed in receives the #upcase! method call' do
      my_string = instance_double("String", upcase!: "UPCASE", empty?: false)
      expect(my_string).to receive(:upcase!)
      new_instance.calls_some_methods(my_string)
    end
    it 'string pass in receives the #reverse! method call.' do
      loud_string = instance_double("String", reverse!: "NOTHING")
      my_string = instance_double("String", empty?: false, upcase!: loud_string)
      expect(loud_string).to receive(:reverse!)
      new_instance.calls_some_methods(my_string)
    end
    it 'returns a completely different object than the one you passed in' do
      loud_string = instance_double("String", reverse!: "NOTHING")
      my_string = instance_double("String", empty?: false, upcase!: loud_string)
      expect(loud_string).not_to equal(my_string)
      new_instance.calls_some_methods(my_string)
    end
  end

end
