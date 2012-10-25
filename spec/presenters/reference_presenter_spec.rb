require 'spec_helper'

describe ReferencePresenter do
  let(:reference)   { build(:monograph) }
  let(:presenter)   { ReferencePresenter.new(reference, view) }
  
  subject { presenter }
 
  context "authors" do

    it "with same author as previous reference" do
      presenter.authors(true).should == "---. "
    end

    describe "with one author" do
      its(:authors) { should == "#{ reference.authors.first }. " }
    end
      
    describe "with two authors" do
      before { reference.authors = build_list(:author, 2) }

      its(:authors) do
        first_author = reference.authors.first
        second_author = reference.authors.last.full_name
        should == "#{ first_author } and #{ second_author }. "
      end
    end

    describe "with three authors" do
      before { reference.authors = build_list(:author, 3) }

      its(:authors) do
        a1, a2, a3, a4 = []
        reference.authors.each_with_index do |a, i|
          case i
            when 0 then a1 = a
            when 1 then a2 = a
            when 2 then a3 = a
          end
        end
        should == "#{ a1 }, #{ a2.full_name }, and #{ a3.full_name }. "
      end
    end
  end
    
  context "title" do

    describe "if reference is a collection" do
      its(:title) { should == "<em>#{ reference.title.titleize }</em>. " }
    end
    
    describe "if reference is a chapter" do
      let(:reference) { build(:chapter) }
      
      it "should include monograph in reference" do
        chapter_title = "\"#{ reference.title.titleize }.\" "
        monograph_title = "<em>#{reference.monograph.title.titleize }</em>. "
        presenter.title.should == chapter_title + monograph_title
      end
    end

    describe "if reference is a journal article" do
      let(:reference) { build(:journal_article) }
      
      it "should include journal in reference" do
        article_title = "\"#{ reference.title.titleize }.\" "
        journal_title = "<em>#{reference.journal.name.titleize }</em>. "
        presenter.title.should == article_title + journal_title
      end
    end

    describe "if reference is a magazine article" do
      let(:reference) { build(:magazine_article) }
      
      it "should include magazine in reference" do
        article_title = "\"#{ reference.title.titleize }.\" "
        magazine_title = "<em>#{reference.magazine.name.titleize }</em>. "
        presenter.title.should == article_title + magazine_title
      end
    end
  end

  context "editors" do

    describe "with one editor" do
      before { reference.editors = [build(:author)] }

      its(:editors) do
        should == "Ed. #{ reference.editors.first.full_name }. "
      end
    end
    
    describe "with two editors" do
      before { reference.editors = build_list(:author, 2) }

      its(:editors) do
        first_editor  = reference.editors.first.full_name
        second_editor = reference.editors.last.full_name
        should == "Ed. #{ first_editor } and #{ second_editor }. "
      end
    end
  end

  context "translators" do

    describe "with one translator" do
      before { reference.translators = [build(:author)] }

      its(:translators) do
        should == "Trans. #{ reference.translators.first.full_name }. "
      end
    end
    
    describe "with two translators" do
      before { reference.translators = build_list(:author, 2) }

      its(:translators) do
        first_translator  = reference.translators.first.full_name
        second_translator = reference.translators.last.full_name
        should == "Trans. #{ first_translator } and #{ second_translator }. "
      end
    end
  end
    
  context "publisher" do
    describe "if reference is a chapter" do
      let(:reference) { build(:chapter) }

      its(:publisher) { should == "#{ reference.monograph.publisher }, " }
    end

    describe "if reference is an journal article" do
      let(:reference) { build(:journal_article) }

      its(:publisher) { should == "#{ reference.journal.publisher }, " }
    end
  end

  context "pages" do
    its(:pages)     { should be_nil }

    describe "if object is an individual reference" do
      let(:reference) { build(:chapter) }

      its(:pages)       { should == "#{ reference.pages }. " }
    end
  end

  context "publication_date" do
    its(:publication_date) do
      should == "#{ reference.publication_date.strftime("%Y") }. "
    end

    describe "if object is a magazine article" do
      let(:reference) { build(:magazine_article)}

      its(:publication_date) do
        should == "#{ reference.publication_date.strftime("%e %b. %Y") }: "
      end
    end
  end

  context "medium" do
    its(:medium)      { should == "#{ reference.medium.capitalize }." }

    describe "if reference is a chapter" do
      let(:reference) { build(:chapter) }

      its(:medium) { should == "#{ reference.monograph.medium.capitalize }." }
    end

    describe "if reference is an article" do
      let(:reference) { build(:journal_article) }

      its(:medium) { should == "#{ reference.journal.medium.capitalize }." }
    end
  end
  
  context "formatted chapter reference" do
    let(:reference) { build(:chapter) }
    
    it "should output a correct mla reference" do 
      s =  "#{ presenter.authors }"
      s += "#{ presenter.title }"
      s += "#{ presenter.publisher }"
      s += "#{ presenter.publication_date }" 
      s += "#{ presenter.pages }"
      s += "#{ presenter.medium }"
      presenter.to_mla.should == s
    end
      
    it "should output --- when author is same" do
      s =  "---. "
      s += "#{ presenter.title }"
      s += "#{ presenter.publisher }"
      s += "#{ presenter.publication_date }"
      s += "#{ presenter.pages }"
      s += "#{ presenter.medium }"
      presenter.to_mla(true).should == s
    end
  end
end