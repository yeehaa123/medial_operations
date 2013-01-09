class VolumeArticle < IndividualReference 
  attr_accessible :volume, :authors, :translators, :editors, :date,
                  :medium

  belongs_to :volume
  delegate :publisher, :translators, :editors, :publication_date, 
           :medium, to: :volume

  validates_presence_of(:volume)
  validates_uniqueness_of :title, scope: :volume

  private

    def author(authors)
      self.authors = ReferenceParser.parse_authors(authors)
      # @al = @a.map(&:to_s).join(". ")
    end

    def chapter_title(title)
      self.title = title.delete(".")
    end

    def book_title(title)
      title = title.delete(".")
      @v = Volume.find_or_initialize_by(author_list: @al, title: title)
      @v.authors << @a 
    end

    def editor(editors)
      @v.editors << ReferenceParser.parse_editors(editors)
    end

    def translator(translators)
      if translators
        @v.translators << ReferenceParser.parse_translators(translators)
      end
    end

    def publisher_name(publisher)
      @v.send(:publisher_name, publisher) 
    end

    def date_of_publication(date)
      @v.send(:date_of_publication, date)
    end

    def medium_of_publication(medium)
      @v.send(:medium_of_publication, medium)
      @v.save
      self.volume = @v
    end
end
