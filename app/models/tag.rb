class Tag
  include Mongoid::Document
  include Mongoid::Slug

  attr_accessible :name, :count, :references, :meetings

  field :name, type: String
  slug :name

  validates_presence_of :name
  
  def to_s
    name
  end

  def to_indexed_json
    self.to_json
  end

  def count
    references.count + meetings.count
  end

  def nice_count
    "Hello Sander, the count is: #{ count}"
  end

  def references
    Reference.fulltext_search(self.to_s)
  end

  def meetings
    Meeting.fulltext_search(self.to_s)
  end
end
