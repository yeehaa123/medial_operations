require 'spec_helper'

describe Author do
  let(:author) { build(:nietzsche) }
  
  subject { author }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:particle) }

  it { should be_valid }
  
  context "name" do
    describe "normal names" do
      its(:to_s)      { should be == "Nietzsche, Friedrich" }
      its(:full_name) { should be == "Friedrich Nietzsche" }
    end

    describe "name with particle" do
      let(:author)    { build(:certeau) }
        
      its(:to_s)       { should be == "Certeau, Michel de" }
      its(:full_name) { should be == "Michel de Certeau" } 
    end
  end
end
