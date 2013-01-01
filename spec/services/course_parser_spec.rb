require 'spec_helper'

describe CourseParser do
  let!(:parser) { CourseParser.new }
  let!(:course) { parser.parse_course(syllabus) } 
  let!(:syllabus) { PandocRuby.convert(IO.read(Rails.root.join("spec", "fixtures", "syllabus.md")), {:f => :markdown, :to => :html5}, 'section_div') } 

  subject { course }

  its(:class)         { should == Course }
  its(:title)         { should == "Medial Operations" }
  its(:title_prefix)  { should == "Art, Science, and Technology" }
  its(:description)   { should include "organization" }
  its(:prerequisites) { should include "Ruby Monk" } 
  its(:requirements)  { should include "faucibus tellus" } 

  it { should have(1).references }
  it { should have(2).sections }
  it { should have(4).meetings }

  it { should be_persisted }

  context 'introduction' do
    let!(:introduction) { course.meetings.first }

    subject { introduction }

    its(:class)     { should == Meeting }
    its(:title)     { should == "Session 1 - Introduction" }
    its(:number)    { should == 1 }
    its(:section)   { should == nil }

    it "should have the correct date and time" do
      introduction.datetime.should == "Tue, 05 Feb 2013 14:00:00 CET +01:00"
    end
    
    it { introduction.location.should == "PCH 6.25" }

    it { should have(0).references }

    it { should be_persisted }
  end

  context 'Section 1' do
    let!(:section) { course.sections.first }

    subject { section }
    
    its(:title)       { should == "Mapping The Humanities" }
    its(:number)      { should == 1 }
    its(:description) { should include "Bla bla bla" }

    it { should have(2).meetings }

    it { should be_persisted }

    context 'Session 2' do
      let!(:meeting) { section.meetings[0] }
      
      subject { meeting }

      its(:title)   { should == "Session 2" }
      its(:number)  { should ==  2 }

      it "should have the correct date and time" do
        meeting.datetime.should == "Tue, 19 Feb 2013 14:00:00 CET +01:00"
      end
    
      it { meeting.location.should == "PCH 6.25" }


      it { should have(4).references }

      it { should be_persisted }
    end

    context 'Session 3' do
      let!(:meeting) { section.meetings[1] }
      
      subject { meeting }

      its(:title)   { should == "Session 3" }
      its(:number)  { should ==  3 }

      it "should have the correct date and time" do
        meeting.datetime.should == "Tue, 26 Feb 2013 14:00:00 CET +01:00"
      end
    
      it { meeting.location.should == "PCH 6.25" }


      it { should have(0).references }

      it { should be_persisted }
    end

    context "Assignment 1" do
      let!(:assignment) { section.assignments.first }

      subject { assignment }

      its(:title)       { should == "Assignment 1" }
      its(:deadline)    { should == "Fri, 01 Mar 2013 00:00:00 CET +01:00" }
      its(:description) { should == "Bla bla bla bla" }
    end
  end

  context 'section 2' do
    let!(:section) { course.sections[1] }

    subject { section }

    its(:title)       { should == "F(r)ictions and/or (Fr)Actions of the Imaginary" }
    
    it { should have(1).meetings }

    context 'Session 4' do
      let!(:meeting) { section.meetings[0] }
      
      subject { meeting }

      its(:title)   { should == "Session 4" }
      its(:number)  { should ==  4 }

      it "should have the correct date and time" do
        meeting.datetime.should == "Tue, 16 Apr 2013 14:00:00 CEST +02:00"
      end
    
      it { meeting.location.should == "PCH 6.25" }

      it { should have(0).references }

      it { should be_persisted }
    end

    it { should be_persisted }
  end

end
