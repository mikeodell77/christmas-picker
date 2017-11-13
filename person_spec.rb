require './person'

RSpec.describe Person, "#can_buy_for" do
  context "with no params" do
    it "throws an exception" do
      person = Person.new(name: "Mike", exclude: [])
      expect{person.can_buy_for?}.to raise_error(ArgumentError)
    end
  end

  context "with params" do
    it "returns true" do
      person = Person.new(name: "Mike", exclude: [])
      expect(person.can_buy_for?(name: "Fred")).to eq(true)
    end

    it "returns false" do
      person = Person.new(name: "Mike", exclude: ["Fred"])
      expect(person.can_buy_for?(name: "Fred")).to eq(false)
    end
  end
end
