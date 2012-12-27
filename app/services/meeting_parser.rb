class MeetingParser
  attr_accessor :meeting

  def initialize(parent)
    if parent.is_a?(Section)
      @meeting = Meeting.new(course: parent.course, section: parent)
    else
      @meeting = Meeting.new(course: parent)
    end
  end

  def parse_meeting(syllabus)
    meeting_title(syllabus)
    meeting.number = Meeting.count + 1
    meeting_info(syllabus)
    meeting.location = "Bungehuis 4.01"
    meeting.save
    meeting
  end

  def meeting_title(syllabus)
    meeting.title = syllabus.css('h3').text
  end

  def meeting_info(syllabus)
    syllabus.css('.level4').each do |m|
      case m['id']
      when /readings/ then references(m)
      end
    end
  end

  def references(r)
    r.css('p').each do |reference|
      meeting.reference(reference.to_html)
    end
  end
end
