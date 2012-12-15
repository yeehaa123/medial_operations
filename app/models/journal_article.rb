class JournalArticle < PeriodicalReference 
  attr_accessible :journal, :date, :medium

  belongs_to  :journal
  delegate    :medium, :publisher, to: :journal

  validates_presence_of :journal

  def medium=(medium = "Print")
    self.journal.update_attributes(medium: medium)
  end

  def self.create_reference(&block)
    reference = self.new
    reference.instance_eval(&block)
    reference.save
    reference
  end

  private
    def author_list(authors)
      self.authors = ReferenceParser.set_authors(authors)
    end

    def article_title(title)
      self.title = title
    end

    def journal_name(journal)
      self.journal = Journal.find_or_create_by(name: journal)
    end

    def year_of_publication(year)
      self.publication_date = Time.new(year)
    end

    def pages(pages)
      pages = pages.split("-").map { |m| m.to_i }
      self.startpage = pages[0]
      self.endpage = pages[1]
    end

    def medium_of_publication(medium)
      self.medium = "Print"
    end
end
