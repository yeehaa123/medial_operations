require 'spec_helper'

describe ReferenceParser do
  
  context "parse" do
    Given(:reference) { ReferenceParser.parse(quotation) }

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

          When  { ReferenceParser.parse(another_quotation) }
          Then  { expect(reference.title).to eq "One-Way-Street." } 
          And   { expect(Reference.count).to eq 2 }
          And   { expect(Author.count).to eq 1 }
          end
      end

      describe "monograph with author with particle in name" do
        Given(:quotation) { "Certeau, Michel de. <em>The Practice of Everyday Life.</em> Minneapolis: University Of Minnesota Press, 1984. Print." }

        Then  { expect(reference.authors.first.to_s).to eq "Certeau, Michel de" }
        And   { expect(reference.title).to eq "The Practice of Everyday Life." }
        And   { expect(reference.publication_date.strftime("%Y")).to eq "1984" }
        And   { expect(reference.medium).to eq "Print" }
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
        And   { expect(reference.startpage).to eq 3 }
        And   { expect(reference.endpage).to eq 9 }
        And   { expect(reference.medium).to eq "Print" }

        describe "another chapter from the same volume" do
          Given(:quotation) { 'Heidegger, Martin. "The Question Concerning Technology." <em>The Question Concerning Technology.</em> Trans. William Lovitt. New York: Harper & Row, 1977. 3-9. Print.' } 

          Then  { expect(reference.authors.first.to_s).to eq "Heidegger, Martin" }
          And   { expect(reference.title).to eq "The Question Concerning Technology." } 
          And   { expect(Monograph.count).to eq 1 }
        end 
      end

      describe "chapter with one author, one editor, and two translators" do
        Given(:quotation) { 'Nietzsche, Friedrich. "Preface to the Second Edition." <em>The Gay Science.</em> Ed. Bernard Williams. Trans. Josefine Nauckhoff, and Adrian Del Caro. Cambridge: Cambridge University Press, 2001. 3-9. Print.' }

        Then  { expect(reference._type).to eq "Chapter" }
        And   { expect(reference.authors.first.to_s).to eq "Nietzsche, Friedrich" }
        And   { expect(reference.title).to eq "Preface to the Second Edition." }
        And   { expect(reference.monograph.title).to eq "The Gay Science." }
        And   { expect(reference.editors.first.to_s).to eq "Williams, Bernard" }
        And   { expect(reference.translators.first.to_s).to eq "Nauckhoff, Josefine" }
        And   { expect(reference.translators.last.to_s).to eq "Del Caro, Adrian" }
        And   { expect(reference.publisher.to_s).to eq "Cambridge: Cambridge University Press" }
        And   { expect(reference.publication_date.strftime("%Y")).to eq "2001" }
        And   { expect(reference.startpage).to eq 3 }
        And   { expect(reference.endpage).to eq 9 }
        And   { expect(reference.medium).to eq "Print" }
      end
    end

    context "articles" do

      describe "magazine article" do
        Given(:quotation) { 'Anderson, Chris. "The End of Theory: The Data Deluge Makes the Scientific Method Obsolete." <em>Wired.</em> 23 Aug 2008. 102-1190. Print.' }

        Then  { expect(reference._type).to eq "MagazineArticle" }
        And   { expect(reference.authors.first.to_s).to eq "Anderson, Chris" }
        And   { expect(reference.title).to eq "The End of Theory: The Data Deluge Makes the Scientific Method Obsolete." }
        And   { expect(reference.magazine.to_s).to eq "Wired" }
        And   { expect(reference.publication_date.strftime("%e %b %Y")).to eq "23 Aug 2008" }
        And   { expect(reference.startpage).to eq 102 }
        And   { expect(reference.endpage).to eq 1190 }
        And   { expect(reference.medium).to eq "Print" }
      end

      describe "journal article" do
        Given(:quotation) { 'Kittler, Friedrich. "Universities: Wet, Hard, Soft, and Harder." <em>Critical Inquiry.</em> (2004): 244-255. Print.' }

        Then  { expect(reference._type).to eq "JournalArticle" }
        And   { expect(reference.authors.first.to_s).to eq "Kittler, Friedrich" }
        And   { expect(reference.title).to eq "Universities: Wet, Hard, Soft, and Harder." }
        And   { expect(reference.journal.to_s).to eq "Critical Inquiry" }
        And   { expect(reference.publication_date.strftime("%Y")).to eq "2004" }
        And   { expect(reference.startpage).to eq 244 }
        And   { expect(reference.endpage).to eq 255 }
        And   { expect(reference.medium).to eq "Print" }
      end
    end
  end

  context "parse_list" do
    describe "empty list" do
      Given(:quotations) {}

      When { ReferenceParser.parse_list(quotations) }
      Then { expect(Reference.count).to eq 0 }
    end  
    
    describe "reference list" do
      Given(:quotations)    { IO.read(Rails.root.join("spec", "fixtures", "references.html")) }
      Given(:technology)   { Monograph.find_by(title: "The Question Concerning Technology.") }

      When  { ReferenceParser.parse_list(quotations) }
      Then  { expect(Reference.count).to eq 11 }
      And   { expect(Monograph.count).to eq 6 }
      And   { expect(Chapter.count).to eq 3 }
      And   { expect(JournalArticle.count).to eq 1 }
      And   { expect(MagazineArticle.count).to eq 1 }
      And   { expect(Journal.count).to eq 1 }
      And   { expect(Magazine.count).to eq 1 }
      And   { expect(Author.count).to eq 13 }
      And   { expect(technology.chapters.count).to eq 2 }
    end
  end
end
