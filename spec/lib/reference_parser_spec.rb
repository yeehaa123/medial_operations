module ReferenceParser
  
    def self.parse(quotation)
    @q = quotation.split(". ") 
    @reference = Monograph.new
    set_title
    set_author
    @reference.save
    @reference
  end

  private

    def self.set_author
      author_list = @q[0].split(" and ")
      al = []
      author_list.each_with_index do |a, i|
        if i == 0
          author_name = a.split(", ")
          author_first_name = author_name[1]
          author_last_name = author_name[0]
        else
          author_name = a.split(" ")
          author_first_name = author_name[0]
          author_last_name = author_name[1]
        end
        al << Author.find_or_create_by(first_name: author_first_name, last_name: author_last_name)
      end
      @reference.authors = al
    end

    def self.set_title
      @reference.title = @q[1]
    end
end

describe ReferenceParser do
  Given(:reference) { ReferenceParser.parse(quotation) }
  
  describe "monograph with one author" do
    Given(:quotation) { "Benjamin, Walter. One-Way-Street." }

    Then  { expect(reference.title).to eq "One-Way-Street." } 
    And   { expect(reference.authors.first.to_s).to eq "Benjamin, Walter" }
    And   { expect(reference._type).to eq "Monograph" }
    
    describe "another reference with same author" do
      Given(:another_quotation) { "Benjamin, Walter. The Arcades Project" }

      When  do 
        ReferenceParser.parse(another_quotation)
        ReferenceParser.parse(quotation)
      end

      Then  { expect(Reference.count).to eq 2 }
      And   { expect(Author.count).to eq 1 }
    end
  end

  describe "monograph with two author" do
    Given(:quotation) { "Deleuze, Gilles and Felix Guattari. A Thousand Plateaus." }

    Then  { expect(reference.title).to eq "A Thousand Plateaus." } 
    And   { expect(reference.authors.first.to_s).to eq "Deleuze, Gilles" }
    And   { expect(reference.authors.last.to_s).to eq "Guattari, Felix" }
    And   { expect(reference._type).to eq "Monograph" }
  end
end
