require 'spec_helper'

describe ChapterPresenter do
  
  let(:presenter)   { ChapterPresenter.new(reference, view) }
  
  subject { presenter }
  
  context "chapter with editor and translators" do
    let(:reference)   { build(:rhizome) }

    describe "#information" do
      its(:information) do
        should == "<p><a href=\"/authors\">Deleuze, Gilles</a>. <a href=\"/authors\">Guattari, Felix</a></p>"
      end
    end

    describe "#to_s" do
      its(:to_s) do
        s = "Deleuze, Gilles and Felix Guattari. "
        s += "\"Rhizome.\" <em>A Thousand Plateaus</em>. "
        s += "Cambridge: Cambridge University Press, 1987. "
        s += "3-25. Print."
        should == s
      end
    end
  end

  context "chapter with editor and translators" do
    let(:reference) { build(:preface) }

    its(:to_s) do
      s = "Nietzsche, Friedrich. "
      s += "\"Preface to the Second Edition.\" <em>The Gay Science</em>. "
      s += "Ed. Bernard Williams. "
      s += "Trans. Josefine Nauckhoff and Adrian Del Caro. "
      s += "Cambridge: Cambridge University Press, 1977. "
      s += "3-9. Print."    
      should == s
    end
  end
end
