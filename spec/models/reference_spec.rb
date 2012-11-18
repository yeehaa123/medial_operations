require 'spec_helper'

describe Reference do
  let(:reference) { build(:reference) }

  subject { reference }
  
  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:editors) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:meetings) }

  it { should validate_presence_of(:title) }

  it { should be_valid }

  its(:to_s) do
    should == "#{ reference.title.titleize }"
  end

  its(:author_list) do 
    should be_nil
  end

  describe "search" do
    before do
      reference.save
    end

    it { Reference.fulltext_search("bla").count.should == 1 }

    describe "three references" do
      let!(:other_references) { create_list(:reference, 2) }

      it { Reference.fulltext_search("bla").count.should == 3 }
    end
  end
end
