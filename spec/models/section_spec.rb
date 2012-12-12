require 'spec_helper'

describe Section do

  Given(:section) { build(:section) }

  subject { section }

  it { should have_fields :title, :description, :number }

  it { should belong_to :course }
  it { should have_many :meetings }
  it { should have_many :assignments }

  it { should validate_presence_of :title }
  it { should validate_presence_of :number }

  it { should be_valid }

  its(:to_s) { should == "#{ section.number } - #{ section.title }" }

  describe "create_section" do
    Given(:course) { create(:course) }
    Given(:section) do
      Section.create_section "1 - New Section", course do
        meeting "New Meeting" do
        end
      end
      course.sections.first
    end

    Then  { expect(section.title).to eq  "New Section" }
    And   { expect(section.number).to eq 1 }
    And   { expect(section).to be_valid }
    And   { expect(section).to be_persisted }
  end
end
