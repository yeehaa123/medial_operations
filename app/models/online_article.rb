class OnlineArticle < IndividualReference
  attr_accessible :website, :access_date

  field :website, type: String
  field :medium, type: String
  field :access_date, type: DateTime

  belongs_to :publisher

  def self.reference(oa)
    self.create_reference do
      author                oa[1]
      article_title         oa[2]
      website_name          oa[3]
      publisher_name        oa[4]
      date_of_publication   oa[5]
      medium_of_publication oa[6]
      date_of_access        oa[7]
    end
  end

  def website_name(website)
    self.website = website.delete(".")
  end

  def publisher_name(publisher)
    nil
  end

  def date_of_publication(date)
      self.publication_date = Time.strptime(date, "%e %b. %Y")
  end
  
  def date_of_access(date)
      self.access_date = Time.strptime(date, "%e %b. %Y")
  end
end
