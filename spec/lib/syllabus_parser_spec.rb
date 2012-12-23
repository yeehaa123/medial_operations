module SyllabusParser
  
  def self.parse(syllabus)
    syllabus = Nokogiri::HTML(syllabus)
    courses(syllabus)
  end

  private

    def self.courses(syllabus)
      syllabus.css('.level1').map do |l1|
        course l1.css('h1').text do
          l1.css('.level2').each do |l2|
            case l2['id']
              when /description/ then course_description l2.css('p').text
              when /section/ then
                section l2.css('h2').text do
                  l2.css('.level3').each do |l3|
                    case l3['id']
                      when /description/ then section_description l3.css('p').text
                      when /session/ then
                        meeting l3.css('h3').text do
                          l3.css('.level4').each do |l4|
                            q = l4.css('p').to_html
                            reference(q)
                          end
                      end
                    end
                  end
                end
            end
          end
        end
      end
    end

    def self.course(title, &block)
      Course.create_course(title, &block)
    end
end

describe SyllabusParser do
  Given(:course) { SyllabusParser.parse(syllabus).first }
  Given(:syllabus) { PandocRuby.convert(IO.read(Rails.root.join("spec", "fixtures", "syllabus.md")), {:f => :markdown, :to => :html5}, 'section_div') } 

  subject { course }

  its(:class)         { should == Course }
  its(:title)         { should == "Medial Operations" }
  its(:title_prefix)  { should == "Art, Science, and Technology" }
  its(:description)   { should include "organization" }
  its(:description)   { should_not include "bla" }
  
  describe "section" do
    Given(:section)   { course.sections.first }
    
    subject { section }

    its(:title)       { should == "Section I" }
    its(:description) { should include "Bla" }

      describe "meeting" do
        Given(:meeting) { section.meetings.first }

        subject { meeting }

        its(:title)   { should == "Session 1" }

        describe "references" do
          Given(:reference) { meeting.references.first }

          subject { reference }

          its(:title) { should == "Eloquent Ruby." }
        end
      end

      describe "last meeting" do
         Given(:meeting) { section.meetings.last }

        subject { meeting }

        its(:title)   { should == "Session 3" }
      end
  end

  it { should be_valid }
end


    #    course_description  c.css('#description').to_html
    #     c.css('.level2').each do |sc|
    #       section sc.css('h2').text do
    #         sc.css('.level3').each do |d|
    #           case d["id"]
    #             when /description/ then section_description d.css('p').to_html
    #             when /session/ then meeting d.css('h3') do |s|
    #             end
    #           end 
    #         end
    #       end
    #     end
    #   end
    # end
 
