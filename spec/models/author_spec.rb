require 'spec_helper'

describe Author do
  let(:author) { build(:nietzsche) }
  
  subject { author }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:particle) }
  
  it { should respond_to(:comments) }

  it { should be_valid }
  
  context "name" do
    describe "normal names" do
      its(:to_s)      { should == "Nietzsche, Friedrich" }
      its(:full_name) { should == "Friedrich Nietzsche" }
      its(:wikipage)  { should == "http://en.wikipedia.org/wiki/Friedrich_Nietzsche" }
      its(:portrait)  { should == "http://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Nietzsche187a.jpg/220px-Nietzsche187a.jpg" }
    end

    describe "name with particle" do
      let(:author)    { build(:certeau) }
        
      its(:to_s)      { should == "Certeau, Michel de" }
      its(:full_name) { should == "Michel de Certeau" } 
      its(:wikipage)  { should == "http://en.wikipedia.org/wiki/Michel_de_Certeau" }
      its(:portrait)  { should == "http://upload.wikimedia.org/wikipedia/en/f/f4/Ambox_content.png" }
    end
  
    describe "with two first names" do
      let(:author)    { build(:donner) }

      its(:to_s)      { should == "Donner, Jan Hein" }
      its(:full_name) { should == "Jan Hein Donner" }
      its(:wikipage)  { should == "http://en.wikipedia.org/wiki/Jan_Hein_Donner" } 
      its(:portrait)  { should == "http://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Jan_Hein_Donner_1978.jpg/220px-Jan_Hein_Donner_1978.jpg" }
    end

    describe "with non-existing wikipage" do
      let(:author)    { build(:nauckhoff) }
      
      its(:to_s)      { should == "Nauckhoff, Josefine" }
      its(:full_name) { should == "Josefine Nauckhoff" }
      its(:wikipage)  { should == nil }
      its(:portrait)  { should == "http://umanitoba.ca/admin/human_resources/lds/media/generic_portrait.jpg" }
    end
  end
end
