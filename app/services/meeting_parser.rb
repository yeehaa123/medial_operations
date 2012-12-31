class MeetingParser < BaseParser

  def initialize(parent)
    if parent.is_a?(Section)
      @object = Meeting.new(course: parent.course, section: parent)
    else
      @object = Meeting.new(course: parent)
    end
  end

  def parse(syllabus)
    info(syllabus) 
    object.save
    object
  end

  def info(syllabus)
    title(syllabus)
    number
    date(syllabus)
    location(syllabus)
    syllabus.css('.level4').each do |m|
      case m['id']
      when /readings/ then references(m)
      end
    end
  end

  def title(syllabus)
    object.title = syllabus.css('h3').text
  end

  def number
    object.number = Meeting.count + 1
  end

  def date(syllabus)
    datetime_regex = /Date: ([A-Za-z]+) (\d*)th (\d{4}) Time: (\d{2}:\d{2})-(\d{2}:\d{2})/
    date = syllabus.css('h3 ~ p').text.match(datetime_regex)
    month = Date::MONTHNAMES.index(date[1])
    start_time = date[4][0..1]
    object.datetime = Time.local(date[3], month, date[2], start_time)
  end

  def location(syllabus)
    location_regex = /Location: ([A-Z]+ .+)/
    location = syllabus.css('h3 ~ p').text.match(location_regex)
    object.location = location[1]
  end

end
