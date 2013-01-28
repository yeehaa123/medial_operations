require 'spec_helper'

describe User do

  Given(:user) { build(:user) }
  
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }

  it { should_not allow_mass_assignment_of(:encrypted_password) }

  it { should have_fields(:first_name, :last_name) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe "#name" do
    Then { user.name.should == "#{ user.first_name } #{ user.last_name }" }
  end

  describe "#slug" do
    When { user.save }
    Then { user.slug.should == "#{ user.name }".to_url }
  end
end
