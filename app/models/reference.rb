class Reference
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field   :title, type: String
  field   :publication_date, type: DateTime
  field   :author_list, type: String

  slug :to_s

  attr_accessible :sessions, :title, :authors, :translators, :editors, 
                  :publisher, :publication_date

  has_and_belongs_to_many   :authors
  has_and_belongs_to_many   :translators, class_name: "Author"
  has_and_belongs_to_many   :editors, class_name: "Author"

  has_and_belongs_to_many   :sessions

  validates_presence_of :title

  before_save :generate_author_list
  
  default_scope asc(:author_list)

  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name INDEX_NAME

  def to_indexed_json
    self.to_json
  end

  def generate_author_list
    al = ""
    if authors.count > 0
      authors.each do |a|
        al += "#{ a.to_s }. "
      end
    end
    self.author_list = al
  end

  def self.search(params)
    tire.search(load: true, type: nil) do
      query { string params[:query] } if params[:query].present?
    end
  end

  def to_s
    title.titleize
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