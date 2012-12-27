require 'spec_helper'

describe CourseParser do
  let!(:parser) { CourseParser.new }
  let!(:course) { parser.parse_course(syllabus) } 
  let!(:syllabus) { PandocRuby.convert(IO.read(Rails.root.join("spec", "fixtures", "syllabus.md")), {:f => :markdown, :to => :html5}, 'section_div') } 

  subject { course }

  its(:class)         { should == Course }
  its(:title)         { should == "Medial Operations" }
  its(:title_prefix)  { should == "Art, Science, and Technology" }
  its(:description)   { should include "Nowadays" }
  its(:description)   { should include "organization" }
  its(:description)   { should_not include "bla" }
   
  it { should have(3).sections }
  it { should have(5).meetings }

  it { should be_persisted }

  context 'introduction' do
    let!(:introduction) { course.meetings.first }

    subject { introduction }

    its(:class)     { should == Meeting }
    its(:title)     { should == "Session 1 - Introduction" }
    its(:number)    { should == 1 }
    
    it { should have(2).references }

    it { should be_persisted }
  end

  context 'Section 1' do
    let!(:section) { course.sections.first }

    subject { section }
    
    its(:class)       { should == Section }
    its(:title)       { should == "Mapping The Humanities" }
    its(:number)      { should == 1 }
    its(:description) { should include "Bla bla bla" }

    it { should have(2).meetings }

    it { should be_persisted }

    context 'Session 2' do
      let!(:meeting) { section.meetings[0] }
      
      subject { meeting }

      its(:class)   { should == Meeting }
      its(:title)   { should == "Session 2" }
      its(:number)  { should ==  2 }

      it { should have(4).references }

      it { should be_persisted }
    end

    context 'Session 3' do
      let!(:meeting) { section.meetings[1] }
      
      subject { meeting }

      its(:class)   { should == Meeting }
      its(:title)   { should == "Session 3" }
      its(:number)  { should ==  3 }

      it { should have(4).references }

      it { should be_persisted }
    end
  end

  context 'section 2' do
    let!(:section) { course.sections[1] }

    subject { section }

    its(:class)       { should == Section }
    its(:title)       { should == "F(r)ictions and/or (Fr)Actions of the Imaginary" }
    
    it { should have(1).meetings }

    context 'Session 4' do
      let!(:meeting) { section.meetings[0] }
      
      subject { meeting }

      its(:class)   { should == Meeting }
      its(:title)   { should == "Session 4" }
      its(:number)  { should ==  4 }

      it { should have(3).references }

      it { should be_persisted }
    end

    it { should be_persisted }
  end

  context 'section 3' do
    let!(:section) { course.sections[2] }

    subject { section }

    its(:class)       { should == Section }
    its(:title)       { should == "The Eternal Recurrence of Body Snatchers" }
    
    it { should have(1).meetings }

    context 'Session 5' do
      let!(:meeting) { section.meetings[0] }
      
      subject { meeting }

      its(:class)   { should == Meeting }
      its(:title)   { should == "Session 5" }
      its(:number)  { should ==  5 }

      it { should have(0).references }

      it { should be_persisted }
    end

    it { should be_persisted }
  end


end
