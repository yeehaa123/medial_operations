require 'spec_helper'

describe ReferencePresenter do
  let(:reference)   { build(:reference) }
  let(:presenter)   { ReferencePresenter.new(reference, view) }
  
  subject { presenter }
 
  context "authors" do

    it "with same author as previous reference" do
      presenter.send(:authors, true).should == "---. "
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

    describe "with more than three authors" do
      before { reference.many_authors = true }

      its(:authors) { should == "#{ reference.authors.first }, et al. " }

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
end
