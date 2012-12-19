class Reference
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::FullTextSearch

  field   :title, type: String
  field   :publication_date, type: DateTime
  field   :tags, type: Array
  field   :author_list, type: String

  slug    :title   

  fulltext_search_in :tags_string
  
  attr_accessible :meetings, :title, :authors, :translators, :editors, 
                  :publication_date, :tags, :set_tags, :tags, :publisher

  has_and_belongs_to_many   :authors, inverse_of: :references
  has_and_belongs_to_many   :translators, class_name: "Author", inverse_of: :references
  has_and_belongs_to_many   :editors, class_name: "Author", inverse_of: :references
  has_and_belongs_to_many   :meetings

  validates_presence_of :title
  
  before_save :generate_author_list
  before_save :set_tags 
  
  def to_s
    title.titleize
  end
  
  def tags_string
    tags.join(', ') if tags
  end

  def set_tags
    if tags
      tags.each do |tag|
        begin
          Tag.find_by(name: tag)
        rescue
          Tag.create(name: tag)
        end
      end
    end
  end

  def generate_author_list
    self.author_list = if authors.size > 0
      authors.map(&:to_s).join(". ")
    else
      ""
    end
  end

  def self.create_reference(&block)
    reference = self.new
    reference.instance_eval(&block)
    reference.save
    reference
  end

  private
    def author(authors)
      authors = parse_authors(authors) 
      self.authors << set_authors(authors)
    end

    def translator(translators)
      if translators
        translators = parse_translators(translators)
        self.translators << set_translators(translators)
      end
    end

    def parse_authors(authors)
      author_list_regex = /([A-Z][a-z]+\s?[A-Za-z]+,\s[a-zA-Z]+)(,\sand\s([a-zA-Z]+\s[a-zA-Z]+)*)?(,\sand\s([a-zA-Z]+\s[a-zA-Z]+)*)?\.?/x
      a = authors.scan(author_list_regex)[0]
      authors = []
      a.each_with_index do |a,i|
        if a && (i%2 == 0)
          authors << a
        end
      end
      authors
    end

    def parse_translators(translators)
      if translators.include?("Trans.")
        translators.gsub!("Trans. ", "").chop!
        translators = translators.split(", and ")
      else
        [translators]
      end
    end
    
    def parse_editors(editors)
      if editors.include?("Ed.")
        editors.gsub!("Ed. ", "")
        editors = editors.strip
        editors = editors.chop
        editors = editors.split(", and ")
      else
        [editors]
      end
   end

    
    def set_authors(parsed_authors)
      authors = []
      parsed_authors.each do |a|
        if a 
          authors << set_author(a)
        end
      end
      return authors
    end
    alias_method :set_editors, :set_authors
    alias_method :set_translators, :set_authors

    def set_author(author)
      if author.include?(",")
        author_name = author.split(", ")
        author_first_name = author_name[1]
        author_last_name = author_name[0]
      else
        author_name = author.split(" ")
        author_first_name = author_name[0]
        if author_name.count > 2
          author_last_name = author_name[1] + " " + author_name[2]
        else
          author_last_name = author_name[1]
        end
      end
      Author.find_or_create_by(first_name: author_first_name, last_name: author_last_name)
    end

    def article_title(title)
      self.title = title
    end

    def date_of_publication(date)
      self.publication_date = Time.new(date)
    end

    def medium_of_publication(medium = "Print")
      self.medium = medium 
    end
end
