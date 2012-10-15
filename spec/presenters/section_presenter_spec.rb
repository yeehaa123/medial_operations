require 'spec_helper'

describe SectionPresenter do
  let(:section)     { build(:section) } 
  let(:presenter)   { SectionPresenter.new(section, view) }
  
  subject { presenter }

  its(:heading) do 
    roman_numeral = presenter.roman_numeral(section.number)
    should == "#{ roman_numeral } - #{ section.title }"
  end
  
  its(:description) { should == "<p>Hello <em>World</em></p>\n" }
end