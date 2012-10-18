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
  has_many      :sessions

  validates_presence_of :title
  validates_presence_of :number

  def to_s
    "#{ number } - #{ title }"
  end
end