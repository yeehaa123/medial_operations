class Meeting 
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::FullTextSearch

  field :title, type: String
  field :datetime, type: Time
  field :description, type: String
  field :location, type: String
  field :number, type: Integer
  field :tags, type: Array

  slug :to_s

  fulltext_search_in :tags_string

  attr_accessible :title, :course, :description, :section, :datetime, 
                  :location, :references, :tags, :set_tags

  belongs_to  :course
  belongs_to  :section
  embeds_many :comments, as: :commentable
  has_and_belongs_to_many :references

  after_save :order_meetings
  before_save :set_tags
  before_save :set_reference_tags
  after_save { update_ngram_index }

  default_scope asc(:datetime)

  validates_presence_of :course
  validates_with RightCourseValidator, if: :section

  def tags_string
    tags.join(', ') if tags
  end

  def set_reference_tags
    if references
      references.each do |r|
        if r.tags
          r.tags.each do |t|
            self.tags ||= []
            unless tags.include?(t)
              self.tags << t
            end
          end
        end
      end
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
    "#{ number } - #{ title.titleize }"
  end

  def order_meetings
    Meeting.where(course: course).each_with_index do |s, i|
      i += 1
      s.set(:number, i)
    end
  end

  def self.create_meeting(title, block_context, &block)
    meeting = self.new(title: title)
    meeting.instance_eval(&block)
    if block_context && block_context.respond_to?(:course)
      meeting.course = block_context.course
    else
      meeting.course = block_context
    end
    meeting.save
    meeting
  end
 
  def meeting_course(course)
    self.course = course
    self
  end

  def reference(quotation)
    self.references << ReferenceParser.parse(quotation)
  end
end

