require 'spec_helper'

describe Comment do
  let(:comment) { build(:comment) }

  subject { comment }

  it { should respond_to(:content) }
  it { should respond_to(:commentable) }

  it { should be_valid }
end
