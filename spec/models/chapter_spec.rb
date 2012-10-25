require 'spec_helper'

describe Chapter do
  let(:chapter) { build(:chapter) }

  subject { chapter }

  it { should respond_to(:monograph) }
  
  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:editors) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:medium) }
  it { should respond_to(:pages) }

  it { should respond_to(:sessions) }

  it { should validate_presence_of(:title) }
end
  