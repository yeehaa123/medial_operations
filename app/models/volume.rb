class Volume < CollectionReference

  attr_accessible :articles
  
  has_many        :articles, class_name: "VolumeArticle"

  validates_presence_of :authors
  belongs_to :publisher

  validates_uniqueness_of :title, scope: :authors

  def editors
    self.authors
  end

  def editors=(editors)
    self.authors=(editors)
  end

  alias_method :editor_list, :author_list

 private
    def book_title(title)
      self.title = title.delete(".")
    end
    alias_method :volume_title, :book_title

   def editor(editors)
     if editors
       self.editors = ReferenceParser.parse_editors(editors)
     end
   end    
   
  def publisher_name(publisher)
    publisher_string = publisher.split(": ")
    publisher_name = publisher_string[1]
    publisher_location = publisher_string[0]
    self.publisher = Publisher.find_or_create_by(name: publisher_name, location: publisher_location)
  end

  def contributors
    self.articles.map do |a|
      a.authors
    end
  end
end
