class Assignment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::FullTextSearch
  
  field :title, type: String
  field :number, type: Integer
  field :deadline, type: Time
  field :description, type: String
 
  attr_accessible :title, :number, :deadline, :course, :description, :section

  belongs_to :course
  belongs_to :section

  validates_presence_of :course
  validates_with RightCourseValidator, if: :section

  def to_s
    title
  end
end
