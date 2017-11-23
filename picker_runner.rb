require 'csv'
require 'json'
require './person'
require './empty_family_file'

class PickerRunner
  def initialize(path_to_file:)
    raise ArgumentError.new("path_to_file is required") if path_to_file == nil

    @path_to_file = path_to_file
    @dynamic_people_pool = []
    @taken = []
    @count = 0
  end

  def run
    results = load_family.map do |person|
      format_result(person, random_selection(person))
    end

    puts results.size
  end

  def format_result(person, result)
    puts "#{person.name} will be buying for #{result.name}"
  end

  def random_selection(person_buying)
    begin
      random_person = @dynamic_people_pool.sample

      if !person_buying.can_buy_for?(name: random_person.name)
        random_selection(person_buying)
      else
        @dynamic_people_pool.delete(random_person)
        return random_person
      end
    rescue SystemStackError
      puts "We have no more available options for #{person_buying.name}, restart application"
    end
  end

  def load_family
    process_family(JSON.parse(File.read(@path_to_file)))
  end

  def process_family(family_members)
    raise EmptyFamilyFile.new if family_members == nil || family_members.empty?
    family = []

    family_members.each do |value|
      person = Person.new(name: value["name"], exclude: value["do_not_buy_for"])
      @dynamic_people_pool << person
      family << person
    end

    return family
  end
end

picker = PickerRunner.new(path_to_file: './family.json')
1.times do
  picker.run
end
