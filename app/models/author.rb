class Author
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :first_name, type: String
  field :last_name, type: String
  field :particle, type: String
  
  slug :full_name

  attr_accessible :references, :first_name, :last_name, :translations, :volumes

  has_and_belongs_to_many :references
  has_and_belongs_to_many :translations, class_name: "Reference"
  has_and_belongs_to_many :volumes, class_name: "Reference"

  def to_s
    if particle
      "#{last_name}, #{first_name} #{ particle }"
    else
      "#{last_name}, #{first_name}"
    end
  end

  def full_name
    if particle
      "#{first_name} #{ particle } #{last_name}"
    else
      "#{first_name} #{last_name}"
    end
  end
end
