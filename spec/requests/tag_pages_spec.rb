require 'spec_helper'

describe "TagPages" do
  let!(:reference) { create(:reference)}
  let!(:tag)       { Tag.find_by(name: "bla") }
  let!(:session)   { create(:session)}

  subject { page }

  context "tag show page" do 
    
    before do 
      Reference.tire.index.delete
      reference.save
      Reference.tire.index.create
      Reference.tire.index.refresh
      visit tag_path(tag)
    end
    
    it { save_and_open_page }
    # it { should have_selector('title', text: "#{ base_title }") }
    # it { should show_menu }
    # it { should have_selector('hgroup.course_title') }
    # it { should have_selector('section.course_description') }
    # it { should_not have_selector('section.sections') }
    # it { should_not have_selector('section.meetings') }
  end
end