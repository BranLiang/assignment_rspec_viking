# Your code here
require 'viking.rb'
require 'pry-byebug'

describe Viking do
  let(:viking){ Viking.new }
  let(:oleg){ Viking.new("Oleg") }
  let(:bran){ Viking.new("Bran") }

  describe '#initialize' do
    it 'set up with a name' do
      new_viking = Viking.new("Bran")
      expect(new_viking.name).to eq("Bran")
    end
    it 'set up with a particular healthy' do
      new_viking = Viking.new("Bran", 101)
      expect(new_viking.health).to eq(101)
    end
    it 'can not over written the health value' do
      new_viking = Viking.new("Bran", 110)
      expect(new_viking.health).to eq(110)
      expect{ new_viking.health = 120 }.to raise_error(NoMethodError)
    end
    it 'has no weapon when initialized' do
      expect(viking.weapon).to be_nil
    end
  end
  describe '#pick_up_weapon' do
    it 'can pick up viking weapon' do
      axe = instance_double("Weapon", :name)
      allow(axe).to receive(:is_a?).with(Weapon).and_return(true)
      viking.pick_up_weapon(axe)
      expect(viking.weapon).to eq(axe)
    end
    it 'can not pick none viking weapon' do
      none_viking_weapon = double
      allow(none_viking_weapon).to receive(:is_a?).with(Weapon).and_return(false)
      expect{ viking.pick_up_weapon(none_viking_weapon) }.to raise_error("Can't pick up that thing")
    end
    it 'replace the old weapon' do
      arrow = instance_double("Weapon")
      axe = instance_double("Weapon")
      allow(arrow).to receive(:is_a?).with(Weapon).and_return(true)
      allow(axe).to receive(:is_a?).with(Weapon).and_return(true)
      viking.pick_up_weapon(arrow)
      expect(viking.weapon).to eq(arrow)
      viking.pick_up_weapon(axe)
      expect(viking.weapon).to eq(axe)
    end
  end
  describe '#drop_weapon' do
    it 'leave the viking weaponless' do
      axe = instance_double("Weapon")
      allow(axe).to receive(:is_a?).with(Weapon).and_return(true)
      viking.pick_up_weapon(axe)
      expect(viking.weapon).to eq(axe)
      viking.drop_weapon
      expect(viking.weapon).to be_nil
    end
  end
  describe '#receive_attack' do
    it 'reduce the viking health by the specified amount' do
      expect(viking.health).to eq(100)
      viking.receive_attack(10)
      expect(viking.health).to eq(90)
    end
    it 'calls the take_damage method' do
      expect(viking).to receive(:take_damage)
      viking.receive_attack(10)
    end
  end
  describe '#attack' do
    it 'cause the recipients health to drop' do
      expect(oleg.health).to eq(100)
      bran.attack(oleg)
      expect(oleg.health).to be < 100
    end
    it 'call the take_damage method' do
      allow(oleg).to receive(:take_damage).and_return(2.5)
      expect(oleg).to receive(:take_damage)
      bran.attack(oleg)
    end
    it 'call method damage_with_fists when attack without weapon' do
      # expect(bran.weapon).to be_nil
      allow(bran).to receive(:damage_with_fists).and_return(10)
      expect(bran).to receive(:damage_with_fists)
      bran.attack(oleg)
    end
    it 'with no weapon deals Fists multiplier times strength damage' do

    end
    it 'with a weapon runs damage_with_weapon' do
      # binding.pry
      # axe = instance_double("Weapon",name: "axe", use: 1)
      weapon = double("weapon", use: 2)
      expect(bran).to receive(:pick_up_weapon).with(weapon)
      # expect(bran).to receive(:weapon).and_return(axe)
      expect(bran).to receive(:damage_with_weapon)
      bran.attack(oleg)
    end
  end
end
