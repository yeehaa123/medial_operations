# coding: UTF-8
class ReferenceParser

  def self.parse_list(quotations = [])
    quotations = Nokogiri::HTML(quotations)
    quotations.search('p').each do |q|
      parse(q.to_html)
    end
  end

  def self.parse(quotation)
    monograph_regex = /([A-Z].+,\s[A-Z].+\.)?\s?<em>(.+)<\/em>\s
                      (Trans\.\s.+\.\s)?(.+:\s.+),\s(\d{4}).\s(Print)\./x 
    chapter_regex =   /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)<\/em>\s
                      (Ed\.\s[A-Za-z ]+\.\s)?(Trans\.\s.+\.\s)?(.+:\s.+),\s
                       (\d{4})\.\s(\d+-\d+)\.\s(Print)\./x
    ma_regex =        /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)\.<\/em>\s
                      (\d{2}\s.+\s\d{4})\.\s(\d+-\d+)?\.\s(Print)\./x
    ja_regex =        /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)<\/em>\s
                      (\d+)\.(\d+)\s\((\d{4})\):\s(\d+-\d+)\.\s(Print)\./x
    oa_regex =        /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)<\/em>\s
                      (n\.p\.|.+),\s(n\.d\.|\d{2}\s.+\s\d{4})\.\s(Web)\.\s
                      (\d+\s.+\s\d{4})\./x

    r = case quotation 
    when chapter_regex then chapter chapter_regex.match(quotation)
    when monograph_regex then monograph monograph_regex.match(quotation)
    when ma_regex then magazine_article ma_regex.match(quotation)
    when ja_regex then journal_article ja_regex.match(quotation)
    when oa_regex then online_article oa_regex.match(quotation)
    end
    @previous_author = r.authors
    r
  end

  def self.many_authors(authors)
    true if authors =~ /,\set\sal\./
  end

  def self.parse_authors(authors)
    author_list_regex = /([A-Z][a-z]+\s?[A-Za-z]+,\s[A-Z\.]*[\p{word}\s]+)
                        (,\s([A-Z][\p{word}]+\s[a-zA-Z]+))?
                        (,\sand\s([\p{word}]+\s[a-zA-Z]+)*)?
                        (,\set\sal)?\.?/x

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
      translators.gsub!("Trans. ", "")
      translators = translators.strip
      translators = translators.chop
      translators = translators.split(", and ")
    else
      translators = [translators]
    end
    set_authors(translators)
  end

  def self.parse_editors(editors)
    if editors.include?("Ed.")
      editors.gsub!("Ed. ", "")
      editors = editors.strip
      editors = editors.chop
      editors = editors.split(", and ")
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
