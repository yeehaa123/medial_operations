require 'spec_helper'

describe VolumeArticlePresenter do
  
  let(:presenter)   { VolumeArticlePresenter.new(reference, view) }
  
  subject { presenter }
  
  context "article with editor" do
    let(:reference)   { build(:code) }

    describe "#to_s" do
      its(:to_s) do
        s =  "Kittler, Friedrich. "
        s += "\"Code (or, How You Can Write Something Differently).\" " 
        s += "<em>Software Studies: A Lexicon</em>. "
        s += "Ed. Matthew Fuller. "
        s += "Cambridge MA: The MIT Press, 2008. " 
        s += "100-200. Print."
        should == s
      end
    end
  end
end
