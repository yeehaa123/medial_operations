require 'spec_helper'

describe Reference do

  Given(:reference) { build(:reference) }

  subject { reference }
  
  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:editors) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:meetings) }
  it { should respond_to(:courses) }

  it { should validate_presence_of(:title) }

  it { should be_valid }

  Then  { expect(reference.to_s).to eq "#{ reference.title.titleize }" }
  And   { expect(reference.author_list).to eq nil }

  describe "search" do

    When { reference.save }

    Then { Reference.fulltext_search("bla").count.should == 1 }

    describe "three references" do

      When { create_list(:reference, 2) }

      Then { Reference.fulltext_search("bla").count.should == 3 }
    end
  end
end
