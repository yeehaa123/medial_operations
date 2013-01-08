class OnlineArticle < IndividualReference
  attr_accessible :website, :access_date, :medium

  field :website, type: String
  field :access_date, type: DateTime

  belongs_to  :website
  delegate    :medium, :publisher, to: :website

  def medium=(medium = "Web")
    self.website.update_attributes(medium: medium)
  end
  
  def website_name(website)
    website = website.delete(".")
    self.website = Website.find_or_create_by(name: website)
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
