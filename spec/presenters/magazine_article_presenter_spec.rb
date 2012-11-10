require 'spec_helper'

describe MagazineArticlePresenter do  
  let(:presenter)   { MagazineArticlePresenter.new(reference, view) }
  
  subject { presenter }
  
  describe "Magazine Article without pages" do
    let(:reference)   { build(:magazine_article) }
  
    its(:to_s) do
      s = "Anderson, Chris. "
      s += "\"The End of Theory: The Data Deluge Makes the Scientific Method Obsolete.\" "
      s += "<em>Wired</em>. "
      s += "23 Aug. 2008. Print."
      should == s
    end
  end

  describe "Magazine Article with pages" do
    let(:reference)   { build(:magazine_article_with_pages) }
  
    its(:to_s) do
      s = "Anderson, Chris. "
      s += "\"The End of Theory: The Data Deluge Makes the Scientific Method Obsolete.\" "
      s += "<em>Wired</em>. "
      s += "23 Aug. 2008: 100-200. Print."
      should == s
    end
  end
end