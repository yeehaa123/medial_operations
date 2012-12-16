class JournalArticle < PeriodicalReference 
  attr_accessible :journal, :date, :medium

  belongs_to  :journal
  delegate    :medium, :publisher, to: :journal

  validates_presence_of :journal

  private
    alias_method  :periodical, :journal
    alias_method  :periodical=, :journal=
    alias_method  :journal_name, :periodical_name
end
