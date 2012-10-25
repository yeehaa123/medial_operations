class Magazine < CollectionReference
  
  attr_accessible :articles, :name

  alias_attribute :name, :title

  has_many    :articles, class_name: "MagazineArticle"
end