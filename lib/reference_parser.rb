module ReferenceParser

  def self.reference(quotation)
    monograph_regex = /([A-Z].+,\s[A-Z].+\.)?\s?<em>(.+)<\/em>\s(Trans\.\s.+\.\s)?(.+:\s.+),\s(\d{4}).\s(Print)\./x 
    chapter_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)<\/em>\s(Ed\.\s.+\.\s)?(Trans\.\s.+\.)?\s(.+:\s.+),\s(\d{4})\.\s(\d+-\d+)\.\s(Print)\./x
    magazine_article_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)\.<\/em>\s(\d{2}\s.+\s\d{4})\.\s(\d+-\d+)?\.\s(Print)\./x
    journal_article_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)\.<\/em>\s\((\d{4})\):\s(\d+-\d+)\.\s(Print)\./x

    m   = monograph_regex.match(quotation)
    c   = chapter_regex.match(quotation)
    ma  = magazine_article_regex.match(quotation)
    ja  = journal_article_regex.match(quotation)

    if c then chapter c
    elsif m then monograph m
    elsif ma then magazine_article ma
    elsif ja then journal_article ja
    end
  end

  private
    
    def self.chapter(c) 
      Chapter.create_reference do
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
    
    def self.monograph(m)
      Monograph.create_reference do
        author                m[1]
        book_title            m[2]
        translator            m[3]
        publisher_name        m[4]
        date_of_publication   m[5]
        medium_of_publication m[6]
      end
    end
    
    def self.magazine_article(ma)
      MagazineArticle.create_reference do
        author                ma[1]
        article_title         ma[2]
        magazine_name         ma[3]
        date_of_publication   ma[4]
        pages                 ma[5]
        medium_of_publication ma[6]
      end
    end

    def self.journal_article(ja)
      JournalArticle.create_reference do
        author                ja[1]
        article_title         ja[2]
        journal_name          ja[3]
        date_of_publication   ja[4]
        pages                 ja[5]
        medium_of_publication ja[6]
      end
    end
end
