require 'spec_helper'

describe MagazineArticle do
  let(:article) { build(:magazine_article) }

  subject { article }

  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:medium) }
  it { should respond_to(:magazine) }
  it { should respond_to(:volume) }
  it { should respond_to(:issue)}
  it { should respond_to(:sessions) }

  it { should validate_presence_of(:title) }
  it { should respond_to(:magazine) }

  it { should be_valid }
    
  it { should have(1).authors }
  it { should have(4).sessions }  
end
