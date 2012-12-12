class Tag
  include Mongoid::Document
  include Mongoid::Slug

  attr_accessible :name

  field :name, type: String
  slug  :name

  validates_presence_of :name
  
  def to_s
    name
  end

  def count
    references.count + meetings.count
  end

  def references
    Reference.fulltext_search(self.to_s)
  end

  def meetings
    Meeting.fulltext_search(self.to_s)
  end
end
