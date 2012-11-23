require 'spec_helper'

describe Publisher do
  let(:publisher) { build(:publisher) }

  subject { publisher }

  it { should respond_to(:name) }
  it { should respond_to(:location) }
  it { should respond_to(:monographs) }
  it { should respond_to(:journals) }


  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:location) }
  # it { should validate_uniqueness_of(:location).scoped_to(:name) }

  it { should be_valid }
end
