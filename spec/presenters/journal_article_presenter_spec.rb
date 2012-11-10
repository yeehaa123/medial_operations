require 'spec_helper'

describe JournalArticlePresenter do
  let(:presenter)   { JournalArticlePresenter.new(reference, view) }
  
  subject { presenter }
  
  describe "Journal Article" do
    let(:reference)   { build(:journal_article) }
  
    its(:to_s) do
      s = "Kittler, Friedrich. "
      s += "\"Universities: Wet, Hard, Soft, and Harder.\" "
      s += "<em>Critical Inquiry</em>. 31.1 (2004): 244-255. "
      s += "Print."
      should == s
    end
  end

  describe "Journal Article without Page Numbers" do
    let(:reference)   { build(:journal_article, startpage: nil, endpage: nil) }

    its(:to_s) do
      s = "Kittler, Friedrich. "
      s += "\"Universities: Wet, Hard, Soft, and Harder.\" "
      s += "<em>Critical Inquiry</em>. 31.1 (2004). "
      s += "Print."
      should == s
    end
  end
end