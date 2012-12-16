class Magazine < Periodical
  has_many    :articles, class_name: "MagazineArticle"
end
