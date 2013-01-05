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
    @object.datetime.advance(hours: 4).strftime("%H:%M")
  end

  def tags
    @object.tags.map { |t| link_to t, tag_path(t) }.join(" ").html_safe if @object.tags
  end

  def textbook
    @object.textbook_readings if @object.textbook_readings
  end
end
