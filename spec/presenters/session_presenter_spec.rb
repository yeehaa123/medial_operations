require 'spec_helper'

describe SessionPresenter do
  let(:session)     { build(:session) }
  let(:presenter)  { CoursePresenter.new(course, view) }
  
  subject { presenter }

  its(:heading)     { should == "New Course" }
  its(:description) { should == "<p>Hello <em>World</em></p>" }
  its(:date) {should == "Date: #{ meeting.start_time.strftime("%A, %B %d") }" }
  its(:location) { should == "Location: #{ meeting.meeting.location }" }
  its(:time) do
    start_time  = meeting.start_time.strftime("%H:%M")
    end_time    = meeting.end_time.strftime("%H:%M")
    should == "Time: #{ start_time } - #{ end_time }"
  end
end