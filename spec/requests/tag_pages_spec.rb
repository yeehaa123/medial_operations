require 'spec_helper'

describe "TagPages" do
  let!(:reference) { create(:reference)}
  let!(:tag)       { Tag.find_by(name: "bla") }
  let!(:meeting)   { create(:meeting)}

  subject { page }

  context "tag show page" do 
    
    before do 
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
