require 'spec_helper'

describe Section do

  let(:section) { build(:section) }

  subject { section }

  it { should respond_to(:course) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:number) }

  it { should be_valid }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:number) }

  its(:to_s) { should == "#{ section.number } - #{ section.title }" }
end
