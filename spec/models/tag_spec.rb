require 'spec_helper'
  
describe Tag do
  let(:tag)       { create(:tag) }
  let(:reference) { create(:reference, tags: [tag.name])}
  let(:session)   { create(:session, tags: [tag.name])}

  subject { tag }

  it { should respond_to(:name) }
  it { should respond_to(:slug) }
  it { should respond_to(:references) }
  it { should respond_to(:sessions) }

  it { should be_valid }

  its(:to_s) { should == tag.name }

  describe "references" do 
    before do
      Reference.tire.index.delete
      Reference.tire.index.create
      reference.save
      Reference.tire.index.refresh
    end

    it { tag.references.results.count.should == 1 }
  end

  describe "session" do 
    before do
      Session.tire.index.delete
      Session.tire.index.create
      session.save
      Session.tire.index.refresh
    end

    it { tag.sessions.results.count.should == 1 }
  end
end