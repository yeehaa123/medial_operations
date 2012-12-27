# require 'spec_helper'
# require 'course_parser'
# 
# describe SectionParser do
#   Given(:parser) { SectionParser.new }
#   Given(:section) { parser.parse_section(Nokogiri::HTML(syllabus)) } 
#   Given(:syllabus) { PandocRuby.convert(IO.read(Rails.root.join("spec", "fixtures", "section.md")), {:f => :markdown, :to => :html5}, 'section_div') } 
#   
#   subject { section }
# 
#   its(:class)       { should == Section }
#   its(:title)       { should == "Section I" }
#   its(:number)      { should == 1   }
#   its(:description) { should include "Bla" }
# 
#   it { expect(section.meetings.length).to eq 2 }
# 
#   it { should be_persisted }
# end
