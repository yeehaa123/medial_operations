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
  it { should respond_to(:sessions) }
  it { should respond_to(:publisher) }

  it { should validate_presence_of(:authors) }
  it { should validate_presence_of(:title) }

  it { should be_valid }
    
  it { should have(1).authors }
  it { should have(2).translators }
  it { should have(3).editors }
  it { should have(4).sessions }  

  
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
end