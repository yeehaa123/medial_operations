class MeetingsController < ApplicationController
  expose(:meeting)
  expose(:course)  { meeting.course }
  expose(:section) { meeting.section }

  def show
  end

end
