class Chapter < IndividualReference 

  attr_accessible :monograph, :authors, :translators, :editors, :date,
                  :medium

  belongs_to :monograph
  delegate :authors, :publisher, :translators, :editors, :publication_date, 
           :medium, to: :monograph

  validates_presence_of(:monograph)
  validates_uniqueness_of :title, scope: :monograph

  def self.reference(c)
    self.create_reference do
      author                c[1]
      chapter_title         c[2] 
      book_title            c[3] 
      editor                c[4]
      translator            c[5] 
      publisher_name        c[6]
      date_of_publication   c[7]
      pages                 c[8]
      medium_of_publication c[9]
    end
  end
 
  private

    def author(authors)
      @a = ReferenceParser.parse_authors(authors)
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
        @m.editors << ReferenceParser.parse_editors(editors)
      end
    end

    def translator(translators)
      if translators
        @m.translators << ReferenceParser.parse_translators(translators)
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
