require 'nokogiri'
require 'open-uri'
require 'net/http'

class Author
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :first_name, type: String
  field :last_name, type: String
  field :particle, type: String
  
  slug :full_name

  attr_accessible :references, :first_name, :last_name, :translations, :volumes, :particle

  has_and_belongs_to_many :references
  has_and_belongs_to_many :translations, class_name: "Reference"
  has_and_belongs_to_many :volumes, class_name: "Reference"
  embeds_many :comments, as: :commentable

  def to_s
    if particle
      "#{last_name}, #{first_name} #{ particle }"
    else
      "#{last_name}, #{first_name}"
    end
  end

  def full_name
    if particle
      "#{first_name} #{ particle } #{last_name}"
    else
      "#{first_name} #{last_name}"
    end
  end
  
  def wikipage
    wiki_link if remote_file_exists?(wiki_link)
  end
  
  def portrait
    if wikipage
      p = Nokogiri::XML(open wikipage)
      "http:#{ p.search('img').first[:src] }"
    else 
      "http://umanitoba.ca/admin/human_resources/lds/media/generic_portrait.jpg"
    end
  end
  
  private
    def wiki_link
      "http://en.wikipedia.org/wiki/#{ full_name.tr(" ", "_") }"
    end

    def remote_file_exists?(url)
      url = URI.parse(url)
      Net::HTTP.start(url.host, url.port) do |http|
        return http.head(url.request_uri).code == "200"
      end
    end
end
