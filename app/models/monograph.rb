class Monograph < CollectionReference

  attr_accessible :chapters
  
  has_many    :chapters

  validates_presence_of :authors

end