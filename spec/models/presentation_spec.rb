require 'spec_helper'

describe Presentation do
  let(:presentation) { build(:presentation)}

  subject { presentation }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:tags) }

  it { should be_valid }

  its(:slug) { should == presentation.title.parameterize }

  describe "set_tags" do

    it "should increase the tag count" do
      expect do
        presentation.tags = ["bla", "ta", "da"]
        presentation.save
      end.to change(Tag, :count).by(3)
    end 
    
    it "should only increase the tag count by one" do
      expect do
        presentation.tags = ["bla", "bla", "bla"]
        presentation.save
      end.to change(Tag, :count).by(1)
    end

    it "should not increase the tag count" do
      
      expect do
        presentation.tags = [""]
        presentation.save
      end.to change(Tag, :count).by(0)

      expect do
        presentation.tags = []
        presentation.save
      end.to change(Tag, :count).by(0)
    
    end
  end
end 