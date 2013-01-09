require 'spec_helper'

describe MonographPresenter do
  let(:presenter)   { MonographPresenter.new(reference, view) }
  
  subject { presenter }

  describe "monograph with two authors" do
    let(:reference)   { build(:a_thousand_plateaus) }

    its(:to_s) do
      s = "Deleuze, Gilles and Felix Guattari. "
      s += "<em>A Thousand Plateaus</em>. "
      s += "Cambridge: Cambridge University Press, 1987. "  
      s += "Print."    
      should == s
    end
  end

  describe "monograph with translators" do
    let(:reference) { build(:the_gay_science) }

    its(:to_s) do
      s = "Nietzsche, Friedrich. "
      s += "<em>The Gay Science</em>. "
      s += "Trans. Josefine Nauckhoff and Adrian Del Caro. "
      s += "Cambridge: Cambridge University Press, 1977. "
      s += "Print."    
      should == s
    end
  end
end
