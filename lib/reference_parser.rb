module ReferenceParser

  def self.reference(quotation)
    monograph_regex = /([A-Z].+,\s[A-Z].+\.)?\s?<em>(.+)<\/em>\s(Trans\.\s.+\.\s)?(.+:\s.+),\s(\d{4}).\s(Print)\./x 
    chapter_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)<\/em>\s(Ed\.\s.+\.\s)?(Trans\.\s.+\.)\s?(.+:\s.+),\s(\d{4})\.\s(\d+-\d+)\.\s(Print)\./x 
    magazine_article_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)\.<\/em>\s(\d{2}\s.+\s\d{4})\.\s(\d+-\d+)?\.\s(Print)\./x
    journal_article_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)\.<\/em>\s\((\d{4})\):\s(\d+-\d+)\.\s(Print)\./x

    m   = monograph_regex.match(quotation)
    c   = chapter_regex.match(quotation)
    ma  = magazine_article_regex.match(quotation)
    ja  = journal_article_regex.match(quotation)

    if c
      authors = set_authors(c[1])
      author_list = authors.map(&:to_s).join(". ")
      monograph = Monograph.find_or_initialize_by(author_list: author_list, title: c[3], 
                                                  publisher: set_publisher(c[6]),
                                                  publication_date: Time.new(c[7].to_i),
                                                  medium: "Print")
      monograph.authors = authors
      monograph.save
      Chapter.create(title: c[2], monograph: monograph,
                     startpage: pages(c[8])[0], endpage: pages(c[8])[1])     
    elsif m
      Monograph.create(title: m[2], authors: set_authors(m[1]), 
                       publisher: set_publisher(m[4]), 
                       publication_date: Time.zone.local(m[5].to_i),
                       medium: "Print")
    elsif ma
      MagazineArticle.create(authors: set_authors(ma[1]), title: ma[2], 
                             magazine: set_magazine(ma[3], ma[6]), 
                             publication_date: Time.strptime(ma[4], "%e %b %Y"),
                             startpage: pages(ma[5])[0], endpage: pages(ma[5])[1])     
    elsif ja
      JournalArticle.create(authors: set_authors(ja[1]), title: ja[2],
                            journal: set_journal(ja[3], ja[6]), 
                            publication_date: Time.new(ja[4]).to_i, 
                            startpage: pages(ja[5])[0], endpage: pages(ja[5])[1]) 
    end
  end

  private

  def self.set_authors(authors)
    author_list_regex = /([a-zA-Z]+,\s[a-zA-Z]+)(,\sand\s([a-zA-Z]+\s[a-zA-Z]+)*)?(,\sand\s([a-zA-Z]+\s[a-zA-Z]+)*)?\./x 
    author_list = author_list_regex.match(authors)
    al = []
    al << set_first_author(author_list[1]) if author_list[1]
    al << set_other_author(author_list[3]) if author_list[3]
    al << set_other_author(author_list[5]) if author_list[5]
    al
  end

  def self.set_first_author(author)
    author_name = author.split(", ")
    author_first_name = author_name[1]
    author_last_name = author_name[0]
    Author.find_or_create_by(first_name: author_first_name, last_name: author_last_name)
  end

  def self.set_other_author(author)
    author_name = author.split(" ")
    author_first_name = author_name[0]
    author_last_name = author_name[1]
    Author.find_or_create_by(first_name: author_first_name, last_name: author_last_name)
  end

  def self.set_publisher(publisher)
    publisher_string = publisher.split(": ")
    publisher_name = publisher_string[1]
    publisher_location = publisher_string[0]
    Publisher.find_or_create_by(name: publisher_name, location: publisher_location)
  end

  def self.set_magazine(magazine, medium)
    Magazine.find_or_create_by(name: magazine, medium: medium)
  end

  def self.set_journal(journal, medium)
    Journal.find_or_create_by(name: journal, medium: medium) 
  end

  def self.pages(pages)
    pages = pages.split("-").map { |m| m.to_i }
  end
end


