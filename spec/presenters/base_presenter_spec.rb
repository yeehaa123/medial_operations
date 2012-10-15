require 'spec_helper'

describe SectionPresenter do
  let(:section)     { build(:section) }
  let(:presenter)   { BasePresenter.new(section, view) }
  
  subject { presenter }

  describe "roman_numeral" do
    
    it { presenter.roman_numeral(4).should == "IV" }
    it { presenter.roman_numeral(49).should == "XLIX"}
    it { presenter.roman_numeral(857).should == "DCCCLVII" }

    its(:roman_numeral) do 
      should == "#{ presenter.roman_numeral(section.number) }"
    end
  end
end