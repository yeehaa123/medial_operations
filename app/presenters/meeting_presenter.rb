class MeetingPresenter < BasePresenter
  presents :meeting

  def date
    "Date: #{ @object.datetime.strftime("%A, %B %d") }"
  end

  def location
    "Location: #{ @object.location }"
  end

  def time
    "Time: #{ start_time } - #{ end_time }"
  end

  def start_time
    @object.datetime.strftime("%H:%M")
  end

  def end_time
    @object.datetime.advance(hours: 3).strftime("%H:%M")
  end
end
