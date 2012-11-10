class Presentation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  field :content, type: String
  field :tags, type: Array

  slug  :title

  attr_accessible :title, :content, :tags, :slug, :set_tags

  before_save :set_tags

  def to_s
    title
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
end
