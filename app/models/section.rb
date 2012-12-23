class Section
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  field :description, type: String
  field :number, type: Integer

  slug :to_s

  attr_accessible :title, :course, :description, :number

  belongs_to    :course
  has_many      :meetings
  has_many      :assignments

  validates_presence_of :title
  validates_presence_of :course
  validates_presence_of :number

  def to_s
    "#{ number } - #{ title }"
  end

  def self.create_section(title, block_context, &block)
    title = title.split(" - ")
    section = self.new(title: title[1], number: title[0].to_i)
    if block_context
      section.course = block_context
    end
    section.instance_eval(&block)
    section.save
    section
  end
  
  def meeting(title, &block)
    self.meetings << Meeting.create_meeting(title, self, &block)
    self  
  end

  def section_title(title)
    self.title = title
    self
  end
  
  def section_number(number)
    self.number = number
    self
  end
  
  def section_description(description)
    self.description = description
    self
  end
end
