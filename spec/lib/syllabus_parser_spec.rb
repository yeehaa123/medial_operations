module SyllabusParser
  
  def self.parse(syllabus)
    syllabus = Nokogiri::HTML(syllabus)
    create_course do
      course_title_prefix   syllabus.search('//p').first.text 
      course_title          syllabus.search('//h1').first.text
      course_description    syllabus.css('section#description').to_html 
    end
  end

  private

    def self.create_course(&block)
      Course.create_course(&block)
    end
end

describe SyllabusParser do
  Given(:course) { SyllabusParser.parse(syllabus) }
  Given(:syllabus) { IO.read(Rails.root.join("spec", "fixtures", "syllabus.html")) } 

  subject { course }

  its(:class) { should == Course }
  its(:title) { should == "Medial Operations" }
  its(:title_prefix)  { should == "Art, Science, and Technology" }
  its(:description)   { should include "organization" }
  its(:description)   { should_not include "bla" }

  it { should be_valid }
end
