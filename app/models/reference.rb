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
      self.authors << ReferenceParser.parse_authors(authors) 
    end

    def translator(translators)
      if translators
        self.translators << ReferenceParser.parse_translators(translators)
      end
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
