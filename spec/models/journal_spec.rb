require 'spec_helper'

describe Journal do
  let(:journal) { build(:journal) }

  subject { journal }

  it { should respond_to(:name) }
  it { should respond_to(:medium) }
  it { should respond_to(:articles) }
  it { should respond_to(:publisher) }
  it { should respond_to(:sessions) }

  it { should validate_presence_of(:title) }

  it { should be_valid }
    
  it { should have(4).sessions }  

  its(:to_s) do
    should == "#{ journal.name.titleize }"
  end
end
