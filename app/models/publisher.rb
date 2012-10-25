class Publisher
  include Mongoid::Document
  
  attr_accessible :location, :name, :magazines, :publications, :references

  field    :name, type: String
  field    :location, type: String

  has_many :references

  validates_presence_of :name
  validates_presence_of :location
  validates_uniqueness_of :location, scope: :name

  def to_s
    "#{ location.titleize }: #{ name.titleize }"
  end
end

