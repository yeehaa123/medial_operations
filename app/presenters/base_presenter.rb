class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def method_missing(*args, &block)
    @template.send(*args, &block)
  end

  def heading
    @object.to_s
  end

  def description
    if @object.description
      markdown(@object.description)
    end
  end

  def roman_numeral(number = @object.number)
    result, numerals = "", [
      [1000, "M"], [900, "CM"], [500, "D"], [400, "CD"],
      [100,  "C"], [90,  "XC"], [50,  "L"], [40,  "XL"],
      [10,   "X"], [9,   "IX"], [5,   "V"], [4,   "IV"],
      [1,    "I"]
    ]
    numerals.each do |order, roman|
      result << roman * (number / order)
      number %= order
    end
    result
  end
end