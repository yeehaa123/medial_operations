require 'spec_helper'

describe OnlineArticlePresenter do  
  let(:presenter)   { OnlineArticlePresenter.new(reference, view) }
  
  subject { presenter }
  
  describe "Online Article" do
    let(:reference)   { build(:online_article) }
  
    its(:to_s) do
      s = "Sample, Mark. "
      s += "\"Criminal Code: The Procedural Logic of Crime in Videogames.\" "
      s += "<em>Sample Reality</em>. "
      s += "14 Jan. 2011. Web. 6 Jan. 2013."
      should == s
    end
  end
end
