class Monograph < CollectionReference

  attr_accessible :chapters
  
  has_many    :chapters

  validates_presence_of :authors
  belongs_to :publisher
end