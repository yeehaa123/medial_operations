class SectionParser
    attr_accessor :section

    def initialize(course)
      @section = Section.new(course: course)
    end

    def parse_section(syllabus)
      section_heading(syllabus)
      section_info(syllabus)
      section.save
      section
    end

    def section_heading(syllabus)
      section_title(syllabus)
      section_number(syllabus)
    end

    def section_title(syllabus)
      header = syllabus.css('h2').text
      section.title = header.split(" - ")[1]
    end

    def section_number(syllabus)
      header = syllabus.css('h2').text
      section.number = header.split(" - ")[0].split[1]
    end

    def section_info(syllabus)
      syllabus.css('.level3').each do |s|
        case s['id']
        when /description/ then description(s)
        when /session/ then meeting(s)
        end
      end
    end

    def description(d)
      section.description = d.css('p').text
    end

    def meeting(m)
      meeting = MeetingParser.new(section)
      meeting = meeting.parse_meeting(m)
    end
end
