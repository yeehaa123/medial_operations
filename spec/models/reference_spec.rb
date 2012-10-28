require 'spec_helper'

describe Reference do
  let(:reference) { build(:reference) }

  subject { reference }
  
  # it { should respond_to(:authors) }
  it { should respond_to(:title) }
  # it { should respond_to(:translators) }
  # it { should respond_to(:editors) }
  # it { should respond_to(:date) }
  # it { should respond_to(:medium) }
  # it { should respond_to(:site_articles) }
  # it { should respond_to(:courses) }
  # it { should respond_to(:meetings) }
  # it { should respond_to(:pages) }

  it { should respond_to(:sessions) }

  # it { should validate_presence_of(:authors) }
  it { should validate_presence_of(:title) }

  # it { should be_valid }
    
  # it { should have(1).authors }
  # it { should have(2).translators }
  # it { should have(2).editors }
  # it { should have(3).meetings }  
  # it { should have(4).site_articles }

  its(:to_s) do
    should == "#{ reference.title.titleize }"
  end

  its(:author_list) do 
    should be_nil
  end
end