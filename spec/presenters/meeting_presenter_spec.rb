require 'spec_helper'

describe MeetingPresenter do
  let(:meeting)     { build(:meeting, number: 1) }
  let(:presenter)   { MeetingPresenter.new(meeting, view) }
  
  subject { presenter }

  its(:heading)     { should == "New Meeting" }
  its(:description) { should == "<p>Hello <em>World</em></p>\n" }
  its(:date) {should == "Date: #{ meeting.datetime.strftime("%A, %B %d") }" }
  its(:location) { should == "Location: #{ meeting.location }" }
  its(:time) do
    start_time  = meeting.datetime.strftime("%H:%M")
    end_time    = meeting.datetime.advance(hours: 4).strftime("%H:%M")
    should == "Time: #{ start_time } - #{ end_time }"
  end
  its(:textbook) { should == "Bla, Chapter 1-20 (1-999)" }
end
