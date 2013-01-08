require 'spec_helper'

describe OnlineArticle do
  let(:article) { build(:online_article) }

  subject { article }
  
  it  { should have_fields :access_date }
  it  { should respond_to :medium }
  it  { should respond_to :publisher }

  it  { should belong_to :website }

  it  { should be_valid }

  describe "create online article" do
    Given(:article) do
      OnlineArticle.create_reference do
        author                  "Sample, Mark"
        article_title           "Criminal Code: The Procedural Logic of Crime in Videogames"
        website_name            "Sample Reality"
        date_of_publication     "14 Jan. 2011"
        medium_of_publication   "Web"
        date_of_access          "6 Jan. 2013"
      end
    end

    Then  { expect(article.authors.first.to_s).to eq "Sample, Mark" }
    And   { expect(article.title).to eq "Criminal Code: The Procedural Logic of Crime in Videogames" }
    And   { expect(article.website.to_s).to eq "Sample Reality" }
    And   { expect(article.publication_date.strftime("%-d %b. %Y")).to eq "14 Jan. 2011" }
    And   { expect(article.medium).to eq "Web" }
    And   { expect(article.access_date.strftime("%-d %b. %Y")).to eq "6 Jan. 2013" }
  end
end
