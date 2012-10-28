require 'spec_helper'

describe JournalPresenter do
  let(:presenter)   { JournalPresenter.new(reference, view) }
  
  subject { presenter }
  
  describe "journal" do
    let(:reference)   { build(:journal) }

    its(:to_s) do
      s = "<em>Critical Inquiry</em>. "
      should == s
    end
  end
end