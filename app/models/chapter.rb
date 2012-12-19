class Chapter < IndividualReference 

  attr_accessible :monograph, :authors, :translators, :editors, :date,
                  :medium

  belongs_to :monograph
  delegate :authors, :publisher, :translators, :editors, :publication_date, 
           :medium, to: :monograph

  private

    def author(authors)
      a   = parse_authors(authors)
      @a  = set_authors(a)
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
      if editors
        editors = parse_editors(editors)
        @m.editors << set_editors(editors)
      end
    end

    def translator(translators)
      if translators
        translators = parse_translators(translators)
        @m.translators << set_translators(translators)
      end
    end

    def publisher_name(publisher)
      @m.send(:publisher_name, publisher) 
    end

    def date_of_publication(date)
      @m.send(:date_of_publication, date)
    end

    def medium_of_publication(medium)
      @m.send(:medium_of_publication, medium)
      @m.save
      self.monograph = @m
    end
end
