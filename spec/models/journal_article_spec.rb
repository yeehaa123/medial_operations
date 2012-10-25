require 'spec_helper'

describe JournalArticle do
  let(:article) { build(:journal_article) }

  subject { article }

  it { should respond_to(:journal) }
  
  it { should respond_to(:medium) }
  it { should respond_to(:pages) }

  it { should respond_to(:sessions) }

  it { should validate_presence_of(:title) }
end
