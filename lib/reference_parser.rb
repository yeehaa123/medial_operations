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
      Monograph.create_reference do
        author                m[1]
        book_title            m[2]
        translator            m[3]
        publisher_name        m[4]
        date_of_publication   m[5]
        medium_of_publication m[6]
      end
    elsif ma
      MagazineArticle.create_reference do
        author                ma[1]
        article_title         ma[2]
        magazine_name         ma[3]
        date_of_publication   ma[4]
        pages                 ma[5]
        medium_of_publication ma[6]
      end
    elsif ja
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

  private

  def self.set_authors(authors)
    author_list_regex = /([a-zA-Z]+,\s[a-zA-Z]+)(,\sand\s([a-zA-Z]+\s[a-zA-Z]+)*)?(,\sand\s([a-zA-Z]+\s[a-zA-Z]+)*)?\.?/x 
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

  def self.pages(pages)
    pages = pages.split("-").map { |m| m.to_i }
  end
end
