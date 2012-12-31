class CourseParser < BaseParser

  def initialize
    @object = Course.new
  end

  def parse_course(syllabus)
    syllabus = Nokogiri::HTML(syllabus)
    title(syllabus)
    info(syllabus)
    introduction(syllabus)
    section(syllabus)
    object.save
    object
  end

  def title(syllabus)
    title = syllabus.css('h1').text
    title = title.split(": ")
    object.title = title[1]
    object.title_prefix = title[0]
  end

  def info(syllabus)
    syllabus.css('h1 ~ .level4').each do |c|
      case c['id']
      when /description/ then description(c)
      when /textbook/ then references(c)
      when /prerequisites/ then prerequisites(c)
      when /requirements/ then requirements(c)
      end
    end
  end
  
  def introduction(syllabus)
    syllabus.css('.level3').each do |m|
      case m['id']
      when /introduction/ then 
        MeetingParser.new(object).parse(m)
      end
    end
  end

  def section(syllabus)
    syllabus.css('h1 ~ .level2').each do |s|
      case s['id']
      when /section/ then 
        SectionParser.new(object).parse(s)
      end
    end
  end

  def requirements(r)
    r = r.css('h4 ~ *').to_html
    object.requirements = r.to_html
  end

  def prerequisites(p)
    p = p.css('h4 ~ *').to_html
    object.prerequisites = p.to_html
  end
end
