class Publisher
  include Mongoid::Document
  
  attr_accessible :location, :name, :magazines, :publications, :monographs

  field    :name, type: String
  field    :location, type: String

  has_many :monographs
  has_many :journals

  validates_presence_of :name
  validates_presence_of :location
  validates_uniqueness_of :location, scope: :name

  def to_s
    "#{ location }: #{ name }"
  end
end
