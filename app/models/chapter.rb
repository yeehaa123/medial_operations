class Chapter < IndividualReference 

  attr_accessible :monograph, :authors, :translators, :editors, :date,
                  :medium

  belongs_to :monograph
  delegate :authors, :publisher, :translators, :editors, :publication_date, 
           :medium, to: :monograph

  private
    
    def author(authors)
      @a  = ReferenceParser.set_authors(authors)
      @al = @a.map(&:to_s).join(". ")
    end

    def chapter_title(title)
      self.title = title
    end

    def book_title(title)
      @m = Monograph.find_or_initialize_by(author_list: @al, title: title)
      @m.authors << @a
    end

    def editor(editors)
      @m.send(:editor, editors)
    end

    def translator(translators)
      @m.send(:translator, translators)
    end

    def publisher_name(publisher)
      @m.send(:publisher_name, publisher) 
    end

    def date_of_publication(date)
      @m.send(:date_of_publication, date)
    end

    def medium_of_publication(medium)
      @m.send(:medium_of_publication, medium)
      self.monograph = @m
    end
end
