class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :title_prefix, type: String
  field :description, type: String
  
  attr_accessible :title, :title_prefix, :description
  
  has_many    :sections
  has_many    :sessions
  
  validates_presence_of :title

  def to_s
    title
  end
end