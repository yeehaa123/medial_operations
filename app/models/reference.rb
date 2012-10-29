class Reference
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field   :title, type: String
  field   :publication_date, type: DateTime
  field   :author_list, type: String

  attr_accessible :sessions, :title, :authors, :translators, :editors, 
                  :publisher, :publication_date

  has_and_belongs_to_many   :authors
  has_and_belongs_to_many   :translators, class_name: "Author"
  has_and_belongs_to_many   :editors, class_name: "Author"
  has_and_belongs_to_many   :sessions

  validates_presence_of :title

  before_save :generate_author_list
  
  default_scope asc(:author_list)

  def generate_author_list
    al = ""
    if authors.count > 0
      authors.each do |a|
        al += "#{ a.to_s }. "
      end
    end
    self.author_list = al
  end

  def to_s
    title.titleize
  end
end