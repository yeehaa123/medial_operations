require 'spec_helper'

describe Magazine do
  let(:magazine) { build(:magazine) }

  subject { magazine }

  it { should respond_to(:name) }
  it { should respond_to(:medium) }
  it { should respond_to(:articles) }

  it { should validate_presence_of(:name) }

  it { should be_valid }
  
  its(:to_s) do
    should == "#{ magazine.name.titleize }"
  end
end
