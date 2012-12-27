class CourseParser
  attr_accessor :course

  def initialize
    @course = Course.new
  end

  def parse_course(syllabus)
    syllabus = Nokogiri::HTML(syllabus)
    course_title(syllabus)
    course_info(syllabus)
    course_meeting(syllabus)
    course_section(syllabus)
    course.save
    course
  end

  def course_title(syllabus)
    title = syllabus.css('h1').text
    title = title.split(": ")
    course.title = title[1]
    course.title_prefix = title[0]
  end

  def course_info(syllabus)
    syllabus.css('.level4').each do |c|
      case c['id']
      when /description/ then description(c)
      end
    end
  end

  def description(d)
    course.description = d.css('p').text
  end

  def course_meeting(syllabus)
    syllabus.css('.level3').each do |m|
      case m['id']
      when /introduction/ then 
        meeting = MeetingParser.new(course)
        meeting = meeting.parse_meeting(m)
      end
    end
  end

  def course_section(syllabus)
    syllabus.css('.level2').each do |s|
      section = SectionParser.new(course)
      section = section.parse_section(s)
    end
  end
end
