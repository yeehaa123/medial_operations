require 'spec_helper'

describe JournalArticle do
  let(:article) { build(:journal_article) }

  subject { article }

  it { should respond_to(:journal) }
  it { should respond_to(:startpage) }
  it { should respond_to(:endpage) }
  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:medium) }
  it { should respond_to(:volume) }
  it { should respond_to(:issue)}
  it { should respond_to(:meetings) }

  it { should validate_presence_of(:title) }
  it { should be_valid }
    
  it { should have(1).authors }
  it { should have(4).meetings } 

  describe "create_journal_article" do
    Given(:quotation) {'Kittler, Friedrich. "Universities: Wet, Hard, Soft, and Harder." <em>Critical Inquiry.</em> (2004): 244-255. Print.' }
    Given(:article) { JournalArticle.create_reference(quotation) }

    Then { expect(article.authors.first).to eq "Kittler, Friedrich" }
  end
end
