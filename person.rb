class Person
  attr_reader :name
  
  def initialize(name: nil, exclude: [])
    @name = name
    @exclude = exclude
  end

  def can_buy_for?(name: nil)
    raise ArgumentError.new("Name is required") if name == nil
    !@exclude.include? name
  end
end
