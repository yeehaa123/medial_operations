class Tag
  include Mongoid::Document
  include Mongoid::Slug

  field :name, type: String
  slug :name
  def to_s
    name
  end
end