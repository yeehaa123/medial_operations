class Periodical
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field   :name, type: String
  field   :medium, type: String

  attr_accessible :articles, :name, :authors

  validates_presence_of :name
  belongs_to :publisher

  def contributors
    a = []
    articles.each do |art|
      a << art.authors unless art.authors == []
    end
    a
  end

  def to_s
    name.titleize
  end
end
