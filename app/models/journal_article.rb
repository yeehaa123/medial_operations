class JournalArticle < PeriodicalReference 
  attr_accessible :journal, :date, :medium

  belongs_to  :journal
  delegate    :medium, :publisher, to: :journal

  validates_presence_of :journal
  validates_uniqueness_of :title, scope: :journal

  private
    def journal_name(journal)
      journal.delete(".")
      self.journal = Journal.find_or_create_by(name: journal)
    end

    alias_method  :periodical, :journal
    alias_method  :periodical=, :journal=
    
    def date_of_publication(date)
      date.delete!("()")
      self.publication_date = Time.new(date)
    end
end
