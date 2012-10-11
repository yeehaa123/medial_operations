class Session
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :datetime, type: DateTime
  field :description, type: String
  field :location, type: String

  attr_accessible :title, :course, :description
  
  belongs_to :course
  belongs_to :section

  validates_presence_of :course
  validates_with RightCourseValidator, if: :section

  def to_s
    title.titleize
  end
end