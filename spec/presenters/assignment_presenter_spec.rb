require 'spec_helper'

describe AssignmentPresenter do
  Given(:assignment)  { build(:assignment) }
  let(:presenter)     { AssignmentPresenter.new(assignment, view) }
  
  subject { presenter }

  its(:heading)     { should == assignment.title }
  its(:description) { should == "<p>Hello <em>World</em></p>\n" }
  its(:deadline)    { should == "Deadline: #{ assignment.deadline.strftime("%A, %B %d") }" }
end
