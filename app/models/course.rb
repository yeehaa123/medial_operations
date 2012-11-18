class Course
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  field :title_prefix, type: String
  field :description, type: String

  slug  :title

  attr_accessible :title, :title_prefix, :description

  has_many    :sections
  has_many    :meetings

  validates_presence_of :title

  def to_s
    title
  end
end
