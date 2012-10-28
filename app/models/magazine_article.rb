class MagazineArticle < PeriodicalReference 

  attr_accessible :pages, :magazine, :date,
                  :medium

  belongs_to  :magazine
  delegate    :medium, to: :magazine

  validates_presence_of   :magazine
end