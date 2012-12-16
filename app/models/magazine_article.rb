class MagazineArticle < PeriodicalReference 

  attr_accessible :magazine, :date, :medium

  belongs_to  :magazine
  delegate    :medium, :publisher, to: :magazine

  validates_presence_of   :magazine

  private
    alias_method :periodical, :magazine
    alias_method :periodical=, :magazine=
    alias_method :magazine_name, :periodical_name

    def date_of_publication(date)
      self.publication_date = Time.strptime(date, "%e %b %Y")
    end
end

