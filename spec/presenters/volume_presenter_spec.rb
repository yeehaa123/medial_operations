require 'spec_helper'

describe VolumePresenter do
  let(:presenter)   { VolumePresenter.new(reference, view) }
  
  subject { presenter }

  describe "monograph with one editor" do
    let(:reference)   { build(:software_studies) }

    its(:to_s) do
      s =  "Fuller, Matthew, ed. "
      s += "<em>Software Studies: A Lexicon</em>. "
      s += "Cambridge MA: The MIT Press, 2008. "  
      s += "Print."    
      should == s
    end
  end
end
