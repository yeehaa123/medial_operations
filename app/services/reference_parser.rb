# coding: UTF-8
class ReferenceParser

  def self.parse_list(quotations = [])
    quotations = Nokogiri::HTML(quotations)
    quotations.search('p').each do |q|
      parse(q.to_html)
    end
  end

  def self.parse(quotation)
    monograph_regex = /([A-Z].+,\s[A-Z].+\.)?\s?<em>(.+)<\/em>\s(Trans\.\s.+\.\s)?(.+:\s.+),\s(\d{4}).\s(Print)\./x 
    chapter_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)<\/em>\s(Ed\.\s[A-Za-z ]+\.\s)?(Trans\.\s.+\.\s)?(.+:\s.+),\s(\d{4})\.\s(\d+-\d+)\.\s(Print)\./x
    magazine_article_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)\.<\/em>\s(\d{2}\s.+\s\d{4})\.\s(\d+-\d+)?\.\s(Print)\./x
    journal_article_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)<\/em>\s(\d+)\.(\d+)\s\((\d{4})\):\s(\d+-\d+)\.\s(Print)\./x

    case quotation 
    when chapter_regex then chapter chapter_regex.match(quotation)
    when monograph_regex then monograph monograph_regex.match(quotation)
    when magazine_article_regex then magazine_article magazine_article_regex.match(quotation)
    when journal_article_regex then journal_article journal_article_regex.match(quotation)
    end
  end

  def self.parse_authors(authors)
    author_list_regex = /([A-Z][a-z]+\s?[A-Za-z]+,\s[\p{word}\s]+)(,\sand\s([\p{word}]+\s[a-zA-Z]+)*)?(,\sand\s([\p{word}]+\s[a-zA-Z]+)*)?\.?/x
    a = authors.scan(author_list_regex)[0]
    authors = []
    a.each_with_index do |author,i|
      if a && (i%2 == 0)
        authors << author
      end
    end
    set_authors(authors)
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
      Chapter.reference c
    end

    def self.monograph(m)
      Monograph.reference m
    end

    def self.magazine_article(ma)
      MagazineArticle.reference ma
    end

    def self.journal_article(ja)
      JournalArticle.reference ja
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
