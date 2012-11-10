class Tag
  include Mongoid::Document
  include Mongoid::Slug

  attr_accessible :name, :count, :references, :sessions

  field :name, type: String
  slug :name

  validates_presence_of :name
  
  include Tire::Model::Search
  include Tire::Model::Callbacks
  index_name INDEX_NAME

  def to_s
    name
  end

  def to_indexed_json
    self.to_json
  end

  def count
    Tag.search(query: "tags:#{ self }").results.count
  end

  def references
    Reference.search(query: "tags:#{ self }")
  end

  def sessions
    Session.search(query: "tags:#{ self }")
  end

  def self.search(params={})
    tire.search(type: nil) do
      query do 
        boolean do
          must { string params[:query], default_operator: "and" } if params[:query].present?
          must { term :tags, params[:tags] } if params[:tags].present?
        end
      end
    end
  end
end
