module ReferenceParser
  
  def self.reference(quotation)
    detect_reference_type(quotation)
  end
  
  def self.detect_reference_type(quotation)
    monograph_regex = /([A-Z].+,\s[A-Z].+\.)?\s?<em>(.+)<\/em>\s(Trans\.\s.+\.\s)?(.+:\s.+),\s(\d{4}).\s(Print)\./x 
    chapter_regex = /([A-Z].+,\s[A-Z].+\.)?\s?"(.+)"\s<em>(.+)<\/em>\s(Ed\.\s.+\.\s)?(Trans\.\s.+\.)\s?(.+:\s.+),\s(\d{4})\.\s(\d+-\d+)\.\s(Print)\./x 
    m = monograph_regex.match(quotation)
    c = chapter_regex.match(quotation)
    if c
      authors = set_authors(c[1])
      author_list = authors.map(&:to_s).join(". ")
      monograph = Monograph.find_or_initialize_by(author_list: author_list, title: c[3], 
                                                  publisher: set_publisher(c[6]),
                                                  publication_date: Time.zone.local(c[7].to_i),
                                                  medium: "Print")
      monograph.authors = authors
      monograph.save
      reference = Chapter.create(title: c[2], monograph: monograph)
    elsif m
      reference = Monograph.create(title: m[2], authors: set_authors(m[1]), 
                                   publisher: set_publisher(m[4]), 
                                   publication_date: Time.zone.local(m[5].to_i),
                                   medium: "Print" )
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
end

describe ReferenceParser do
  
  Given(:reference) { ReferenceParser.reference(quotation) }
  
  context "monograph" do

    describe "monograph with one author" do

      Given(:quotation) { "Benjamin, Walter. <em>One-Way-Street.</em> Bla: Cla, 1940. Print." }

      Then  { expect(reference._type).to eq "Monograph" }
      And   { expect(reference.authors.first.to_s).to eq "Benjamin, Walter" }
      And   { expect(reference.title).to eq "One-Way-Street." } 
      And   { expect(reference.publisher.to_s).to eq "Bla: Cla" }
      And   { expect(reference.publication_date.strftime("%Y")).to eq "1940" }
      And   { expect(reference.medium).to eq "Print" }


      describe "another reference with same author" do

        Given(:another_quotation) { "Benjamin, Walter. <em>The Arcades Project.</em> Bla: Dla, 1950. Print." }

        When  { ReferenceParser.reference(another_quotation) }
        Then  { expect(reference.title).to eq "One-Way-Street." } 
        And   { expect(Reference.count).to eq 2 }
        And   { expect(Author.count).to eq 1 }
        end
    end

    describe "monograph with two authors" do

      Given(:quotation) { "Deleuze, Gilles, and Felix Guattari. <em>A Thousand Plateaus.</em> Bla: Bla, 1970. Print." }
      
      Then  { expect(reference._type).to eq "Monograph" }
      And   { expect(reference.authors.first.to_s).to eq "Deleuze, Gilles" }
      And   { expect(reference.authors.last.to_s).to eq "Guattari, Felix" }
      And   { expect(reference.title).to eq "A Thousand Plateaus." } 
      And   { expect(reference.publisher.to_s).to eq "Bla: Bla" }
      And   { expect(reference.publication_date.strftime("%Y")).to eq "1970" }
      And   { expect(reference.medium).to eq "Print" }
    end

    describe "monograph with three authors" do

      Given(:quotation) { "Deleuze, Gilles, and Bull Shit, and Felix Guattari. <em>A Thousand Plateaus.</em> Bla: Bla, 1970. Print." }

      Then  { expect(reference.title).to eq "A Thousand Plateaus." } 
      And   { expect(reference.authors.first.to_s).to eq "Deleuze, Gilles" }
      And   { expect(reference.authors[1].to_s).to eq "Shit, Bull" }
      And   { expect(reference.authors.last.to_s).to eq "Guattari, Felix" }
      And   { expect(reference._type).to eq "Monograph" }
    end
  end

  context "chapter" do

    describe "chapter with one author and one translator" do

      Given(:quotation) { 'Heidegger, Martin. "The Age of the World Picture." <em>The Question Concerning Technology.</em> Trans. William Lovitt. New York: Harper & Row, 1977. 3-9. Print.' } 

      Then  { expect(reference._type).to eq "Chapter" }
      And   { expect(reference.authors.first.to_s).to eq "Heidegger, Martin" }
      And   { expect(reference.title).to eq "The Age of the World Picture." }
      And   { expect(reference.monograph.title).to eq "The Question Concerning Technology." }
      And   { expect(reference.publisher.to_s).to eq "New York: Harper & Row" }
      And   { expect(reference.publication_date.strftime("%Y")).to eq "1977" }
      And   { expect(reference.medium).to eq "Print" }

      describe "another chapter from the same volume" do

        Given(:quotation) { 'Heidegger, Martin. "The Question Concerning Technology." <em>The Question Concerning Technology.</em> Trans. William Lovitt. New York: Harper & Row, 1977. 3-9. Print.' } 

        Then  { expect(reference.authors.first.to_s).to eq "Heidegger, Martin" }
        And   { expect(reference.title).to eq "The Question Concerning Technology." } 
        And   { expect(Monograph.count).to eq 1 }
      end 
    end

    describe "chapter with one author, one editor, and two translators" do

      Given(:quotation) { 'Nietzsche, Friedrich. "Preface to the Second Edition." <em>The Gay Science.</em> Ed. Bernard Williams. Trans. Josefine Nauckhoff and Adrian Del Caro. Cambridge: Cambridge University Press, 2001. 3-9. Print.' }

      Then { expect(reference._type).to eq "Chapter" }
    end
  end
end
