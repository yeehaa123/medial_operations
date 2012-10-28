class Journal < CollectionReference
  
  attr_accessible :articles, :name

  has_many    :articles, class_name: "JournalArticle"

  validates_presence_of :name
end