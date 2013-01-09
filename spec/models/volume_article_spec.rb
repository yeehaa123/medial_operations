require 'spec_helper'

describe VolumeArticle do
  let(:article) { build(:volume_article) }

  subject { article }

  it { should respond_to(:volume) }
  
  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:editors) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:medium) }
  it { should respond_to(:endpage) }
  it { should respond_to(:authors) }
  
  it { should respond_to(:meetings) }

  it { should validate_presence_of(:title) } 
  it { should validate_presence_of(:volume) }
  it { should validate_uniqueness_of(:title).scoped_to(:volume) }
 
  describe "#editor" do
    before do
      article.editors << [build(:author)]
    end

    it "editors should be same as volume's" do  
      editor = article.editors.first
      coeditor = article.editors.last
      expect(editor).to eq article.volume.editors.first
      expect(coeditor).to eq article.volume.editors.last
      expect(editor).not_to eq coeditor
    end
  end

  describe "create_reference" do
    Given(:article) do
      VolumeArticle.create_reference do
        author                "Kittler, Friedrich" 
        article_title         "Code"
        book_title            "Software Studies" 
        editor                "Fuller, Matthew"
        publisher_name        "Cambridge: Cambridge University Press"
        date_of_publication   "2001"
        pages                 "3-9"
        medium_of_publication "Print"
      end
    end

    Then  { expect(article.authors.first.to_s).to eq "Kittler, Friedrich" }
    And   { expect(article.title).to eq "Code" }
    And   { expect(article.volume.to_s).to eq "Software Studies" }
    And   { expect(article.editors.first.to_s).to eq "Fuller, Matthew" }
    And   { expect(article.publisher.to_s).to eq "Cambridge: Cambridge University Press" }
    And   { expect(article.publication_date.strftime("%Y")).to eq "2001" }
    And   { expect(article.medium).to eq "Print" }

    And   { expect(article).to be_valid }
    And   { expect(article).to be_persisted }
    And   { expect(article.volume).to be_persisted }
  end
end
