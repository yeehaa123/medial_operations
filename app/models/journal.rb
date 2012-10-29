class Journal < Periodical
  has_many    :articles, class_name: "JournalArticle"
end