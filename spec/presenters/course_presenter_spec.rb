require 'spec_helper'

describe CoursePresenter do
  let(:course)     { build(:course) }
  let(:presenter)  { CoursePresenter.new(course, view) }
  
  subject { presenter }
  
  # it { CoursePresenter.presents(:course == course }

  it { should respond_to(:heading) }
  it { should respond_to(:description) }

  its(:heading)     { should == "New Course" }
  its(:description) { should == "<p>Hello <em>World</em></p>\n" }
end