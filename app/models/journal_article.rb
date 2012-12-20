class JournalArticle < PeriodicalReference 
  attr_accessible :journal, :date, :medium

  belongs_to  :journal
  delegate    :medium, :publisher, to: :journal

  validates_presence_of :journal

  def self.reference(ja)
    self.create_reference do
      author                ja[1]
      article_title         ja[2]
      journal_name          ja[3]
      date_of_publication   ja[4]
      pages                 ja[5]
      medium_of_publication ja[6]
    end
  end

  private
    def journal_name(journal)
      self.journal = Journal.find_or_create_by(name: journal)
    end

    alias_method  :periodical, :journal
    alias_method  :periodical=, :journal=
end
