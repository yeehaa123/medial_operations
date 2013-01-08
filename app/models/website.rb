class Website < Periodical
  has_many    :articles, class_name: "OnlineArticle"
end
