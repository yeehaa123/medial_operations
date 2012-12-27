require 'spec_helper'

describe MagazineArticle do
  let(:article) { build(:magazine_article) }

  subject { article }

  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:medium) }
  it { should respond_to(:magazine) }
  it { should respond_to(:volume) }
  it { should respond_to(:issue) }
  it { should respond_to(:startpage) }
  it { should respond_to(:endpage) }
  it { should respond_to(:meetings) }
  it { should respond_to(:publisher) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:magazine) }
  it { should validate_uniqueness_of(:title).scoped_to(:magazine) }

  it { should be_valid }
    
  it { should have(1).authors }
  it { should have(4).meetings }  

  describe "create_magazine" do
    Given(:article) do
      MagazineArticle.create_reference do
        author                "Anderson, Chris"
        article_title         "The End of Theory: The Data Deluge Makes the Scientific Method Obsolete."
        magazine_name         "Wired"
        date_of_publication   "23 Aug 2008"
        pages                 "102-1190"
        medium_of_publication "Print"
      end
    end

    Then  { expect(article.authors.first.to_s).to eq "Anderson, Chris" }
    And   { expect(article.title).to eq "The End of Theory: The Data Deluge Makes the Scientific Method Obsolete" }
    And   { expect(article.magazine.to_s).to eq "Wired" }
    And   { expect(article.publication_date.strftime("%e %b %Y")).to eq "23 Aug 2008" }
    And   { expect(article.startpage).to eq 102 }
    And   { expect(article.endpage).to eq 1190 }
    And   { expect(article.medium).to eq "Print" }

    And   { expect(article).to be_valid }
    And   { expect(article).to be_persisted }
  end
end
