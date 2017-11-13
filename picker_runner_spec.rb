require './picker_runner'
require './empty_family_file'

RSpec.describe PickerRunner do
  it 'raises an exception due to misssing param' do
    expect{PickerRunner.new}.to raise_error(ArgumentError)
  end

  context '#run' do
    it 'returns something' do
      picker = PickerRunner.new(path_to_file: './family.json')
      expect(picker.run).to eq(19)
    end
  end

  context '#load_family' do
    it 'returns an array of people' do
      picker = PickerRunner.new(path_to_file: './family.json')
      family = picker.load_family
      expect(family.length).to eq(19)
    end
  end

  context '#process_family' do
    it 'returns an array of person objects' do
      families = [{"name": "Mike", "do_not_buy_for": "Tricia"}]
      picker = PickerRunner.new(path_to_file: './family.json')
      family_members = picker.process_family(families)
      expect(family_members.length).to eq(1)
    end

    it 'raises an exception due to missing family members' do
      picker = PickerRunner.new(path_to_file: './family.json')
      expect { picker.process_family([]) }.to raise_error(EmptyFamilyFile)
    end
  end
end
