require 'spec_helper'

describe Chapter do
  let(:chapter) { build(:chapter) }

  subject { chapter }

  it { should respond_to(:monograph) }
  
  it { should respond_to(:authors) }
  it { should respond_to(:title) }
  it { should respond_to(:translators) }
  it { should respond_to(:editors) }
  it { should respond_to(:publication_date) }
  it { should respond_to(:medium) }
  it { should respond_to(:endpage) }
  it { should respond_to(:authors) }
  
  it { should respond_to(:meetings) }

  it { should validate_presence_of(:title) } 
  it { should validate_presence_of(:monograph) }
  it { should validate_uniqueness_of(:title).scoped_to(:monograph) }

  it { should be_valid }
 
  describe "create_reference" do
    Given(:chapter) do
      Chapter.create_reference do
        author                "Nietzsche, Friedrich" 
        chapter_title         "Preface to the Second Edition."
        book_title            "The Gay Science." 
        translator            "Nauckhoff, Josefine"
        translator            "Del Caro, Adrian"
        publisher_name        "Cambridge: Cambridge University Press"
        date_of_publication   "2001"
        pages                 "3-9"
        medium_of_publication "Print"
      end
    end

    Then  { expect(chapter.authors.first.to_s).to eq "Nietzsche, Friedrich" }
    And   { expect(chapter.title).to eq "Preface to the Second Edition" }
    And   { expect(chapter.monograph.to_s).to eq "The Gay Science" }
    And   { expect(chapter.translators.first.to_s).to eq "Nauckhoff, Josefine" }
    And   { expect(chapter.translators.last.to_s).to eq "Del Caro, Adrian" }
    And   { expect(chapter.publisher.to_s).to eq "Cambridge: Cambridge University Press" }
    And   { expect(chapter.publication_date.strftime("%Y")).to eq "2001" }
    And   { expect(chapter.medium).to eq "Print" }

    And   { expect(chapter).to be_persisted }
    And   { expect(chapter.monograph).to be_persisted }

    describe "should not add the same volume twice" do
      Given(:other_chapter) do
        Chapter.create_reference do
          author                "Nietzsche, Friedrich" 
          chapter_title         "Preface to the Third Edition."
          book_title            "The Gay Science." 
          translator            "Nauckhoff, Josefine"
          translator            "Del Caro, Adrian"
          publisher_name        "Cambridge: Cambridge University Press"
          date_of_publication   "2001"
          pages                 "31-91"
          medium_of_publication "Print"
        end
      end

      before do
        chapter
        other_chapter
      end

      Then  { expect(Monograph.count).to eq 1 }
      And   { expect(Chapter.count).to eq 2 }
      And   { expect(Author.count).to eq 3 }

      And   { expect(other_chapter).to be_persisted }
    end
  end
end
