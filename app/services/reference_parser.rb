# coding: UTF-8
class ReferenceParser

  def self.parse_list(quotations = [])
    quotations = Nokogiri::HTML(quotations)
    quotations.search('p').each do |q|
      parse(q.to_html)
    end
  end

  def self.parse(quotation)
    authors           = /([A-Z\-][^\/"<]+)?/
    # authors           = /([A-Z].+,\s[A-Z].+\.)?\s?/
    individual_title  = /"(.+)"\s/ 
    collection_title  = /<em>(.+)<\/em>\s/
    volume_number     = /(\d+)\./
    issue_number      = /(\d+)\s/
    editors           = /(Ed\.\s[A-Za-z ]+\.\s)?/
    translators       = /(Trans\.\s.+\.\s)?/
    publisher         = /(n\.p\.|.+|.+:\s.+),\s/
    year              = /(\(\d{4}\)|\d{4}).\s/ 
    date              = /(n\.d\.|\d+\s.+\s\d{4})\.\s?/
    pages             = /(\d+-\d+)\.\s/
    medium            = /(Print|Web)\./

    monograph_regex = /
                      #{ authors }
                      #{ collection_title }
                      #{ editors }
                      #{ translators }
                      #{ publisher }
                      #{ year }
                      #{ medium }
                      /x
    va_regex =        /
                      #{ authors }
                      #{ individual_title }
                      #{ collection_title }                  
                      #{ editors }
                      #{ translators }
                      #{ publisher }
                      #{ year }
                      #{ pages } 
                      #{ medium }
                      \~/x
    chapter_regex =   /
                      #{ authors }
                      #{ individual_title }
                      #{ collection_title }
                      #{ editors }
                      #{ translators }
                      #{ publisher }
                      #{ year }
                      #{ pages }
                      #{ medium }
                      /x
    ma_regex =        /
                      #{ authors }
                      #{ individual_title }
                      #{ collection_title }
                      #{ date }
                      #{ pages }
                      #{ medium }
                      /x
    ja_regex =        /
                      #{ authors }
                      #{ individual_title }
                      #{ collection_title }
                      #{ volume_number }
                      #{ issue_number }
                      #{ year }
                      #{ pages }
                      #{ medium }
                      /x
    oa_regex =        /
                      #{ authors }
                      #{ individual_title }
                      #{ collection_title }
                      #{ publisher }
                      #{ date }
                      #{ medium }\s
                      #{ date }
                      /x

    reference = case quotation 
    when monograph_regex then monograph monograph_regex.match(quotation)
    when va_regex then
      binding.pry
      volume_article va_regex.match(quotation)
    when chapter_regex then chapter chapter_regex.match(quotation)
    when ma_regex then magazine_article ma_regex.match(quotation)
    when ja_regex then journal_article ja_regex.match(quotation)
    when oa_regex then online_article oa_regex.match(quotation)
    else binding.pry
    end
    reference
  end

  def self.many_authors(authors)
    true if authors =~ /,\set\sal\./
  end

  def self.parse_authors(authors)
    author_list_regex = /
                        ([A-Z][a-z]+\s?[A-Za-z]+,\s[A-Z\.]*[\p{word}\s]+)
                        (,\s([A-Z][\p{word}]+\s[a-zA-Z]+))?
                        (,\sand\s([\p{word}]+\s[a-zA-Z]+)*)?
                        (,\set\sal)?\.?
                        /x

    if authors
      a = authors.scan(author_list_regex)[0]
      authors = []
      a.each_with_index do |author,i|
        if i%2 == 0
          authors << author
        end
      end
      set_authors(authors)
    else
      @previous_author
    end
  end

  def self.parse_translators(translators)
    if translators.include?("Trans.")
      translators.gsub!("Trans. ", "").strip!.chop!
      translators = translators.split(" and ")
    else
      translators = [translators]
    end
    set_authors(translators)
  end

  def self.parse_editors(editors)
    if editors.include?("Ed.")
      editors.gsub!("Ed. ", "").strip!.chop!
      editors = editors.split(" and ")
    else
      editors = [editors]
    end
    set_authors(editors)
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
    
    def self.volume_article(va)
      VolumeArticle.create_reference do
        author                va[1]
        editor                va[4]
        chapter_title         va[2] 
        book_title            va[3] 
        translator            va[5] 
        publisher_name        va[6]
        date_of_publication   va[7]
        pages                 va[8]
        medium_of_publication va[9]
      end
    end

    def self.monograph(m)
      Monograph.create_reference do
        author                m[1]
        book_title            m[2]
        editor                m[3]
        translator            m[4]
        publisher_name        m[5]
        date_of_publication   m[6]
        medium_of_publication m[7]
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

    def self.online_article(oa)
      OnlineArticle.create_reference do
        author                oa[1]
        article_title         oa[2]
        website_name          oa[3]
        publisher_name        oa[4]
        date_of_publication   oa[5]
        medium_of_publication oa[6]
        date_of_access        oa[7]
      end
    end

    def self.journal_article(ja)
      JournalArticle.create_reference do
        author                ja[1]
        article_title         ja[2]
        journal_name          ja[3]
        volume                ja[4]
        issue                 ja[5]
        date_of_publication   ja[6]
        pages                 ja[7]
        medium_of_publication ja[8]
      end
    end

    def self.set_authors(parsed_authors)
      authors = []
      parsed_authors.each do |a|
        if a 
          authors << set_author(a)
        end
      end
      authors
    end

    def self.set_author(author)
      if author.include?(",")
        author = set_first_author(author)
      else
        author = set_other_author(author) 
      end
      Author.find_or_create_by(first_name: author[:first_name], particle: author[:particle],
                               last_name: author[:last_name])
    end

    def self.set_first_author(author)
      name = author.split(", ")
      first_name = name[1].split(" ")
      count = first_name.count
      author = {}
      author[:last_name] = name[0]
      if count == 1
        author[:first_name] = first_name[0]
      elsif first_name[count - 1] =~ /\A[a-z].+/
        author[:particle] = first_name[1]
        author[:first_name] = first_name[0]
      else
        author[:first_name] = first_name[0] + " " + first_name[1]
      end
      author 
    end

    def self.set_other_author(author)
      name = author.split(" ")
      count = name.count
      author = {}
      author[:first_name] = name[0]
      if count <= 2
        author[:last_name] = name[1]
      elsif name[count - 2] =~ /\A[a-z].+/
        author[:particle] = name[2]
      elsif name[count - 2] =~ /Del/
        author[:last_name] = name[1] + " " + name[2]
      else
        author[:last_name] = name[2]
        author[:first_name] = name[0] + " " + name[1]
      end
      author 
    end
end
