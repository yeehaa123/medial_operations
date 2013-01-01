class AssignmentParser < BaseParser

  def initialize(section)
    @object = Assignment.new(course: section.course, section: section)
  end

  def parse(syllabus)
    title(syllabus) 
    info(syllabus)
    object.save
    object
  end

  def info(syllabus)
    title(syllabus)
    syllabus.css('p').each do |p|
      case p.text
      when /Deadline:/ then deadline(p)
      else description(p)
      end
    end
  end  
  
  def deadline(deadline)
    deadline_regex = /Deadline: ([A-Za-z]+) (\d*)[a-z]+ (\d{4})/
    date = deadline.text.match(deadline_regex)
    month = Date::MONTHNAMES.index(date[1])
    object.deadline = Time.local(date[3], month, date[2])
  end

  def description(d)
    object.description = d.children.to_html
  end
end
