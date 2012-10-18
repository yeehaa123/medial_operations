class Author
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :first_name, type: String
  field :last_name, type: String
  field :particle, type: String
  
  attr_accessible :references, :first_name, :last_name, :translations, :volumes

  has_and_belongs_to_many :references
  has_and_belongs_to_many :translations, class_name: "Reference"
  has_and_belongs_to_many :volumes, class_name: "Reference"

  def to_s
    "#{last_name}, #{first_name}"
  end
end