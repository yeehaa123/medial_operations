FactoryGirl.define do

  factory :assignment do
    sequence(:title)  { |n| "Assignment #{ n }" }
    description       "Hello *World*"
    deadline          Time.zone.local(2013, "feb", 10,18,00)
    course

    factory :assignment_with_section do
      section
      course { section.course }
    end
  end


  factory :course do
    title   "Medial Operations"
    description   "Hello *World*"
    title_prefix  "12345"

    factory :defined_course do
      after(:build) do |course|
        course.meetings << create(:meeting, course: course, title: "Introduction")
        3.times { course.sections << create(:section, course: course) }
        course.sections.each do |section|
          3.times { course.meetings << create(:meeting, course: course, 
                                             section: section) }
        end
      end
    end     
  end
  
  factory :section do
    title   "New Section"
    description   "Hello *World*"
    sequence(:number) { |n| n }
    course
  end  
  
  factory :meeting do
    title         "New Meeting"
    description   "Hello *World*"
    location      "Bungehuis 4.01"    
    datetime      Time.zone.local(2013,"jan", 3,10,00)
    tags ["bla"]
    textbook_readings "Bla, Chapter 1-20 (1-999)"
    course

    factory :meeting_with_section do
      section
      course { section.course }
    end
  end

  factory :reference do
    title "New reference"
    tags ["bla"]
    after(:build) do |reference|
      reference.authors = [build(:author)]
      reference.translators = build_list(:author, 2)
      reference.editors = build_list(:author, 3)
    end
  end

  factory :monograph do
    title "New Monograph"
    after(:build) do |reference|
      reference.authors = [build(:author)]
      reference.translators = build_list(:author, 2)
      reference.meetings = build_list(:meeting, 4)
    end

    factory :a_thousand_plateaus do
      title "A Thousand Plateaus"
      publication_date  Time.new(1987)
      medium  "print"
      after(:build) do |reference|
        reference.authors = [build(:deleuze), build(:guattari)]
        reference.translators = nil
        reference.editors = nil
        reference.publisher = build(:cambridge_university_press)
      end
    end

    factory :the_gay_science do
      title   "The Gay Science"
      publication_date    Time.new(1977)
      medium  "print"
      after(:build) do |reference|
        reference.authors = [build(:nietzsche)]
        reference.translators = [build(:nauckhoff), build(:del_caro)]
        reference.publisher = build(:cambridge_university_press)
      end
    end
  end

  factory :volume do
    title "New Volume"
    after(:build) do |reference|
      reference.editors = [build(:author)]
    end

    factory :software_studies do
      title "Software Studies: A Lexicon"
      publication_date  Time.new(2008)
      medium "print"
      after(:build) do |reference|
        reference.authors = [build(:fuller)]
        reference.publisher = build(:mit_press)
      end
    end
  end

  factory :journal do
    name "Critical Inquiry"
    medium  "print"
    after(:build) do |reference|
      reference.publisher = build(:chicago_university_press)
    end  
  end

  factory :magazine do
    name "Wired"
    medium  "print"
  end

  factory :website do
    name    "Sample Reality"
    medium  "Web"
  end

  factory :volume_article do
    title "New Article"
    startpage 100
    endpage 200
    volume
  end

  factory :chapter do
    title "New Chapter"
    startpage 100
    endpage 200
    monograph
    
    factory :rhizome do
      title "Rhizome"
      startpage 3
      endpage 25
      after(:build) do |reference|
        reference.monograph = build(:a_thousand_plateaus)
      end
    end

    factory :preface do
      title "Preface to the Second Edition"
      startpage 3
      endpage 9      
      after(:build) do |reference|
        reference.monograph = build(:the_gay_science)
      end
    end
  end

  factory :journal_article do
    title "Universities: Wet, Hard, Soft, and Harder"
    publication_date    Time.new(2004)
    journal
    startpage 244
    endpage 255
    volume 31
    issue 1
    after(:build) do |reference|
      reference.authors = [build(:kittler)]
      reference.meetings = build_list(:meeting, 4)
    end
  end

  factory :magazine_article do
    title "The End of Theory: The Data Deluge Makes the Scientific Method Obsolete"
    publication_date    Time.new(2008, 8, 23)
    volume  17
    issue   12
    magazine
    after(:build) do |reference|
      reference.authors = [build(:anderson)]
      reference.meetings = build_list(:meeting, 4)
    end

    factory :magazine_article_with_pages do
      startpage 100
      endpage 200
    end
  end

  factory :online_article do
    title "Criminal Code: The Procedural Logic of Crime in Videogames"
    publication_date  Time.new(2011, 1, 14)
    access_date       Time.new(2013, 1, 6)
    website
    after(:build) do |reference|
      reference.authors = [build(:sample)]
    end
  end

  factory :comment do
    content "bla bla bla"
  end

  factory :author do
    first_name  "Jane"
    # middle_name "H."
    sequence(:last_name) { |n| "#{n}-Doe" }
    after(:build) do |author|
      author.comments = [build(:comment)]
    end

    factory :anderson do
      first_name "Chris"
      last_name "Anderson"
    end
    
    factory :certeau  do
      first_name  "Michel"
      particle    "de"
      last_name   "Certeau"
    end

    factory :fuller do
      first_name  "Matthew"
      last_name   "Fuller"
    end

    factory :sample  do
      first_name  "Mark"
      last_name   "Sample"
    end


    factory :nietzsche do
      first_name "Friedrich"
      last_name "Nietzsche"
    end

    factory :deleuze do
      first_name "Gilles"
      last_name "Deleuze"
    end
    
    factory :guattari do
      first_name "Felix"
      last_name "Guattari"
    end

    factory :kittler do
      first_name "Friedrich"
      last_name "Kittler"
    end

    factory :nauckhoff do
      first_name "Josefine"
      last_name "Nauckhoff"
    end

    factory :del_caro do
      first_name "Adrian"
      last_name "Del Caro"
    end

    factory :donner do
      first_name "Jan Hein"
      last_name "Donner"
    end

    factory :williams do
      first_name "Bernard"
      last_name "Williams"
    end
  end

  factory :publisher do
    name  "Cambridge University Press"
    location "Cambridge"

    factory :cambridge_university_press do
      name  "Cambridge University Press"
      location "Cambridge"
    end

    factory :mit_press do
      name "The MIT Press"
      location "Cambridge MA"
    end

    factory :minneapolis_university_press do
      name  "Minneapolis University Press"
      location "Minneapolis"
    end
    

    factory :chicago_university_press do
      name  "Chicago University Press"
      location "Chicago"
    end
  end

  factory :tag do
    sequence(:name) {|n| "Tag #{n}"}
  end

  factory :presentation do
    title "New Presentation"
    content "New Content"
  end
end
