require 'spec_helper'

describe SessionPresenter do
  let(:session)     { build(:session, number: 1) }
  let(:presenter)   { SessionPresenter.new(session, view) }
  
  subject { presenter }

  its(:heading)     { should == "1 - New Session" }
  its(:description) { should == "<p>Hello <em>World</em></p>\n" }
  its(:date) {should == "Date: #{ session.datetime.strftime("%A, %B %d") }" }
  its(:location) { should == "Location: #{ session.location }" }
  its(:time) do
    start_time  = session.datetime.strftime("%H:%M")
    end_time    = session.datetime.advance(hours: 3).strftime("%H:%M")
    should == "Time: #{ start_time } - #{ end_time }"
  end
end