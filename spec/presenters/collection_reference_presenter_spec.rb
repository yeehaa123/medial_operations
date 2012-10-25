require 'spec_helper'

describe CollectionReferencePresenter do
  let(:reference)   { build(:monograph) }
  let(:presenter)   { CollectionReferencePresenter.new(reference, view) }
  
  subject { presenter }
  
  its(:title) { should == "<em>New Monograph</em>. " }
end