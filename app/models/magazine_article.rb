class MagazineArticle < PeriodicalReference 

  attr_accessible :magazine, :date, :medium

  belongs_to  :magazine
  delegate    :medium, :publisher, to: :magazine

  validates_presence_of   :magazine
  validates_uniqueness_of :title, scope: :magazine
  
 private
    alias_method :periodical, :magazine
    alias_method :periodical=, :magazine=

   def magazine_name(magazine)
    self.magazine = Magazine.find_or_create_by(name: magazine)
   end

    def date_of_publication(date)
      self.publication_date = Time.strptime(date, "%e %b %Y")
    end
end
