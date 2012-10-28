class Magazine < CollectionReference
  
  attr_accessible :articles, :name

  has_many    :articles, class_name: "MagazineArticle"

  validates_presence_of :name
end