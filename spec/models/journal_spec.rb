require 'spec_helper'

describe Journal do
  let(:journal) { build(:journal) }

  subject { journal }

  it { should respond_to(:name) }
  it { should respond_to(:articles) }
  it { should respond_to(:publisher) }

  it { should validate_presence_of(:name) }

  it { should be_valid }

  its(:to_s) do
    should == "#{ journal.name.titleize }"
  end
end