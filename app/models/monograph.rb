class Monograph < CollectionReference

  attr_accessible :chapters
  
  has_many    :chapters

  validates_presence_of :authors
  belongs_to :publisher

  private
    def book_title(title)
      self.title = title
    end
    alias_method :monograph_title, :book_title

    def editor(editors)
      if editors
        self.editors << ReferenceParser.set_authors(editors)
      end
    end

    def publisher_name(publisher)
      publisher_string = publisher.split(": ")
      publisher_name = publisher_string[1]
      publisher_location = publisher_string[0]
      self.publisher = Publisher.find_or_create_by(name: publisher_name, location: publisher_location)
    end
end
