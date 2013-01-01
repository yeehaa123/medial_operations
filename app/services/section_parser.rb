class SectionParser < BaseParser

    def initialize(course)
      @object = Section.new(course: course)
    end

    def parse(syllabus)
      title(syllabus)
      number(syllabus)
      info(syllabus)
      meeting(syllabus)
      object.save
      object
    end

    def title(syllabus)
      header = syllabus.css('h2').text
      object.title = header.split(" - ")[1]
    end

    def number(syllabus)
      header = syllabus.css('h2').text
      object.number = header.split(" - ")[0].split[1]
    end

    def info(syllabus)
      syllabus.css('.level4').each do |s|
        case s['id']
        when /description/ then description(s)
        end
      end
    end
    
    def meeting(syllabus)
    syllabus.css('.level3').each do |m|
      case m['id']
      when /session/ then 
        MeetingParser.new(object).parse(m)
      when /assignment/ then
        AssignmentParser.new(object).parse(m)
      end
    end
  end

end
