class Section
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :number, type: Integer

  belongs_to    :course
  has_many      :sessions

  validates_presence_of :title
  validates_presence_of :number

  def to_s
    "#{ number } - #{ title }"
  end
end