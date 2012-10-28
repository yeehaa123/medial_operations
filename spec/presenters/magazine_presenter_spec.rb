require 'spec_helper'

describe MagazinePresenter do
  let(:presenter)   { MagazinePresenter.new(reference, view) }
  
  subject { presenter }
  
  describe "magazine" do
    let(:reference)   { build(:magazine) }

    its(:to_s) do
      s = "<em>Wired</em>. "
      should == s
    end
  end
end