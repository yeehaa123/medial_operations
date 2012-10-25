class JournalArticle < PeriodicalReference 

  attr_accessible :pages, :journal, :date,
                  :medium

  belongs_to  :journal
  delegate    :medium, :publisher, to: :journal
end