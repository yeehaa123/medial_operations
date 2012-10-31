class MagazineArticle < PeriodicalReference 

  attr_accessible :magazine, :date,
                  :medium

  belongs_to  :magazine
  delegate    :medium, :publisher, to: :magazine

  validates_presence_of   :magazine
end