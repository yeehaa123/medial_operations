require 'spec_helper'

describe Reference do
  let(:reference) { build(:reference) }

  subject { reference }
  
  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:editors) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:sessions) }

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
      Reference.tire.index.delete
      Reference.tire.index.create
      reference.save
      Reference.tire.index.refresh
    end

    it { Reference.search(query: "tags:bla").results.count.should == 1 }

    describe "three references" do
      before do
        create(:reference, title: "another")
        create(:reference, title: "athird")
        Reference.tire.index.refresh
      end

      it { Reference.search(query: "tags:bla").results.count.should == 3 }
    end
  end
end
