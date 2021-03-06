class Course
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  field :title_prefix, type: String
  field :description, type: String
  field :requirements, type: String
  field :prerequisites, type: String

  slug  :title

  attr_accessible :title, :title_prefix, :description, :requirements

  has_many  :sections
  has_many  :meetings
  has_many  :assignments
  has_and_belongs_to_many  :references

  validates_presence_of :title

  def to_s
    title
  end

  def self.create_course(title, &block)
    title = title.split(": ")
    course = self.new(title: title[1], title_prefix: title[0])
    course.instance_eval(&block)
    course.save
    course
  end
  
  def course_description(description)
    self.description = description
    self
  end

  def course_requirements(requirements)
    self.requirements = requirements 
    self
  end

  def section(title, &block)
    self.sections << Section.create_section(title, self, &block)
  end

  def meeting(title, &block)
    self.meetings << Meeting.create_meeting(title, self, &block)
  end

  def reference(quotation)
    self.references << ReferenceParser.parse(quotation)
  end
end
