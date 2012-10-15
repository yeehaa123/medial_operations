class Session
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  field :datetime, type: DateTime
  field :description, type: String
  field :location, type: String
  field :number, type: Integer

  slug :to_s

  attr_accessible :title, :course, :description, :section, :datetime, :location

  belongs_to  :course
  belongs_to  :section
  
  after_save :order_sessions

  default_scope asc(:datetime)

  validates_presence_of :course
  validates_with RightCourseValidator, if: :section

  def to_s
    "#{ number } - #{ title.titleize }"
  end

  def order_sessions
    Session.where(course: course).each_with_index do |s, i|
      i += 1
      s.set(:number, i)
    end
  end
end