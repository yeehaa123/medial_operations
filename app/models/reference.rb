class Reference
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field   :title, type: String
  field   :publication_date, type: DateTime
  field   :tags, type: Array
  field   :author_list, type: String
  slug    :to_s

  attr_accessible :sessions, :title, :authors, :translators, :editors, 
                  :publisher, :publication_date, :tags, :set_tags, :tags

  has_and_belongs_to_many   :authors
  has_and_belongs_to_many   :translators, class_name: "Author"
  has_and_belongs_to_many   :editors, class_name: "Author"
  has_and_belongs_to_many   :sessions

  validates_presence_of :title
  
  before_save :generate_author_list, :set_tags 
  
  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name INDEX_NAME

  default_scope asc('author_list')
    
  def to_indexed_json
    self.to_json
  end

  def self.search(params={})
    tire.search(load: true, per_page: 50, type: nil) do
      query do 
        boolean do
          must { string params[:query], default_operator: "AND" } if params[:query].present?
          must { term :tags, params[:tags] } if params[:tags].present?
          must { terms :_type, ["chapter", "magazine_article", "journal_article", "monograph"] }
        end
      end
      facet('tag_list') { terms :tags, order: 'term' }
    end
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

  def to_s
    title.titleize
  end

  def generate_author_list
    self.author_list = if authors.size > 0
      authors.map(&:to_s).join(". ")
    else
      ""
    end
  end

  # def self.tagged_with(name)
  #   Tag.find_by(name: name).references
  # end
  
  # def tag_list
  #   tags.map(&:name).join(", ")
  # end
  
  # def tag_list=(names)
  #   self.tags = names.split(",").map do |n|
  #     Tag.where(name: n.strip).first_or_create!
  #   end
  # end
end