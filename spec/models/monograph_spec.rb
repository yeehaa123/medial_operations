require 'spec_helper'

describe Monograph do
  let(:monograph) { build(:monograph) }

  subject { monograph }

  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:editors) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:medium) }
  it { should respond_to(:chapters) }
  it { should respond_to(:meetings) }
  it { should respond_to(:publisher) }

  it { should validate_presence_of(:authors) }
  it { should validate_presence_of(:title) }

  it { should be_valid }
    
  it { should have(1).authors }
  it { should have(2).translators }
  it { should have(3).editors }
  it { should have(4).meetings }  

  
  describe "author_list" do
    let(:author) { monograph.authors.first }
    before do
      author.save
      monograph.save
    end

    its(:author_list) { should == "#{ author }" }

    describe "with more authors" do
      let(:coauthor) { create(:author) }

      before do
        monograph.authors << coauthor
        monograph.save
      end

      its(:author_list) { should == "#{ author }. #{ coauthor }" }
    end
  end

  describe "create_reference" do
    # Given(:quotation) { 'Benjamin, Walter. <em>One-Way-Street.</em> Bla: Cla, 1940. Print.' }
    Given(:monograph) do
      Monograph.create_reference do
        author                "Benjamin, Walter"
        book_title            "One-Way-Street" 
        publisher_name        "Bla: Cla"
        date_of_publication   "1940"
        medium_of_publication "Print"
      end
    end

    Then  { expect(monograph.authors.first.to_s).to eq "Benjamin, Walter" }
    And   { expect(monograph.title).to eq "One-Way-Street" }
    And   { expect(monograph.publisher.to_s).to eq "Bla: Cla" }
    And   { expect(monograph.publication_date.strftime("%Y")).to eq "1940" }
    And   { expect(monograph.medium).to eq "Print" }

    And   { expect(monograph).to be_valid }
    And   { expect(monograph).to be_persisted }
  end
end
