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
    # Given(:quotation) {'Kittler, Friedrich. "Universities: Wet, Hard, Soft, and Harder." <em>Critical Inquiry.</em> (2004): 244-255. Print.' }
    Given(:article) do
      JournalArticle.create_reference do
        author                "Kittler, Friedrich"
        article_title         "Universities: Wet, Hard, Soft, and Harder."
        journal_name          "Critical Inquiry"
        date_of_publication   "2004"
        pages                 "244-255"
        medium_of_publication "Print"
      end
    end

    Then  { expect(article.authors.first.to_s).to eq "Kittler, Friedrich" }
    And   { expect(article.title).to eq "Universities: Wet, Hard, Soft, and Harder." }
    And   { expect(article.journal.to_s).to eq "Critical Inquiry" }
    And   { expect(article.publication_date.strftime("%Y")).to eq "2004" }
    And   { expect(article.startpage).to eq 244 }
    And   { expect(article.endpage).to eq 255 }
    And   { expect(article.medium).to eq "Print" }

    And   { expect(article).to be_valid }
    And   { expect(article).to be_persisted }
  end
end
