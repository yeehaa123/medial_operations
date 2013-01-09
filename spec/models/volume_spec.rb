#coding: UTF-8
#
require 'spec_helper'

describe Volume do
  let(:volume) { build(:volume) }

  subject { volume }

  it { should have_and_belong_to_many :authors }
  it { should respond_to :editors }

  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:medium) }
  it { should respond_to(:articles) }
  it { should respond_to(:meetings) }
  it { should respond_to(:publisher) }

  it { should validate_presence_of(:authors) }
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title).scoped_to(:authors) }

  it { should be_valid }
    
  it { should have(1).authors }
  it { should have(0).translators }
  it { should have(0).meetings }  

  
  describe "author_list" do
    let(:editor) { volume.editors.first }
    before do
      editor.save
      volume.save
    end

    its(:author_list) { should == "#{ editor }" }

    describe "with more authors" do
      let(:coeditor) { create(:author) }

      before do
        volume.editors << coeditor
        volume.save
      end

      its(:editor_list) { should == "#{ editor }. #{ coeditor }" }
    end
  end
end
