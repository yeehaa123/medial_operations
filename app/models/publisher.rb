class Publisher
  include Mongoid::Document
  
  field    :name, type: String
  field    :location, type: String

  has_many :references
end