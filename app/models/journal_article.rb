class JournalArticle < PeriodicalReference 
  attr_accessible :journal, :date, :medium

  belongs_to  :journal
  delegate    :medium, :publisher, to: :journal

  validates_presence_of :journal

  def medium=(medium)
    self.journal.update_attributes(medium: medium)
  end
end
