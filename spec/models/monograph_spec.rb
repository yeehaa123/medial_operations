#coding: UTF-8

require 'spec_helper'

describe Monograph do
  let(:monograph) { build(:monograph) }

  subject { monograph }

  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:medium) }
  it { should respond_to(:chapters) }
  it { should respond_to(:meetings) }
  it { should respond_to(:publisher) }

  it { should validate_presence_of(:authors) }
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title).scoped_to(:authors) }

  it { should be_valid }
    
  it { should have(1).authors }
  it { should have(2).translators }
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

  context "create_reference" do

    describe "reference" do
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
    end    

    describe "reference with author with particle in name" do
      Given(:monograph) do
        Monograph.create_reference do
          author                "Certeau, Michel de"
          book_title            "The Practice of Everyday Life"
          publisher_name        "Minneapolis: University Of Minnesota Press"
          date_of_publication   "1984"
          medium_of_publication "Print"
        end
      end

      Then  { expect(monograph.authors.first.to_s).to eq "Certeau, Michel de" }
      And   { expect(monograph.title).to eq "The Practice of Everyday Life" }
      And   { expect(monograph.publisher.to_s).to eq "Minneapolis: University Of Minnesota Press" }
      And   { expect(monograph.publication_date.strftime("%Y")).to eq "1984" }
      And   { expect(monograph.medium).to eq "Print" }

      And   { expect(monograph).to be_valid }
    end

    describe "reference with an editor and two translators" do
      Given(:monograph) do
        Monograph.create_reference do
          author                "Nietzsche, Friedrich" 
          book_title            "The Gay Science" 
          editor                "Williams, Bernard"
          translator            "Nauckhoff, Josefine"
          translator            "Del Caro, Adrian"
          publisher_name        "Cambridge: Cambridge University Press"
          date_of_publication   "2001"
          medium_of_publication "Print"
        end
      end

      Then  { expect(monograph.authors.first.to_s).to eq "Nietzsche, Friedrich" }
      And   { expect(monograph.title).to eq "The Gay Science" }
      And   { expect(monograph.editors.first.to_s).to eq "Williams, Bernard" }
      And   { expect(monograph.translators.first.to_s).to eq "Nauckhoff, Josefine" }
      And   { expect(monograph.translators.last.to_s).to eq "Del Caro, Adrian" }
      And   { expect(monograph.publisher.to_s).to eq "Cambridge: Cambridge University Press" }
      And   { expect(monograph.publication_date.strftime("%Y")).to eq "2001" }
      And   { expect(monograph.medium).to eq "Print" }

      And   { expect(monograph).to be_valid }
    end
  end

  describe "reference with two authors" do
    Given(:monograph) do
      Monograph.create_reference do
        author                "Deleuze, Gilles"
        author                "Guattari, Félix"
        book_title            "A Thousand Plateaus"
        publisher_name        "Bla: Bla"
        date_of_publication   "1984"
        medium_of_publication "Print"
      end
    end
    
    Then  { expect(monograph.authors.first.to_s).to eq "Deleuze, Gilles" }
    And   { expect(monograph.authors.last.to_s).to eq "Guattari, Félix" }
    And   { expect(monograph.title).to eq "A Thousand Plateaus" }
    And   { expect(monograph.publisher.to_s).to eq "Bla: Bla" }
    And   { expect(monograph.publication_date.strftime("%Y")).to eq "1984" }
    And   { expect(monograph.medium).to eq "Print" }

    And   { expect(monograph).to be_valid }
  end
end
