require 'spec_helper'

describe Session do
  let(:session) { build(:session, number: 1) }

  subject { session }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:course) }
  it { should respond_to(:datetime) }
  it { should respond_to(:section) }
  it { should respond_to(:references)}

  it { should be_valid }
  it { should validate_presence_of(:course) }

  describe "only assign sections belonging to right course" do
    let(:session) { build(:session_with_section) }
    let(:other_course) { Course.new }
    
    before do 
      session.course = other_course
    end

    it { should_not be_valid }
    it { should have(1).error_on(:section) }
  end

  its(:to_s) { should == "#{ session.number } - #{ session.title.titleize }" }

  describe "order sessions" do
    let(:course)   { create(:defined_course) }
    let(:sessions) { course.sessions }
    let(:session)  { sessions.find_by(title: "Introduction").reload }
    
    its(:number) { should == 1 }

    it "after updating datetime should change number" do
      session.datetime = Time.new(2030)
      session.save
      session.reload.number.should == 10
      session.datetime = Time.now
      session.save
      session.reload.number.should == 1
    end
  end

  describe "search" do
    before do
      Session.tire.index.delete
      session.save
      Session.tire.index.create
      Session.tire.index.refresh
    end

    it { Session.search(query: "tags:bla").results.count.should == 1 }

    describe "three sessions" do
      before do
        create(:session, title: "another")
        create(:session, title: "athird")
        Session.tire.index.refresh
      end

      it { Session.search(query: "tags:bla").results.count.should == 3 }
    end
  end
end