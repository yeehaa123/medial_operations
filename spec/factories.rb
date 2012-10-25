FactoryGirl.define do

  factory :course do
    title   "New Course"
    description   "Hello *World*"
    title_prefix  "12345"

    factory :defined_course do
      after(:build) do |course|
        course.sessions << create(:session, course: course, title: "Introduction")
        3.times { course.sections << create(:section, course: course) }
        course.sections.each do |section|
          3.times { course.sessions << create(:session, course: course, 
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
  
  factory :session do
    title         "New Session"
    description   "Hello *World*"
    location      "Bungehuis 4.01"    
    datetime      Time.zone.local(2013,"jan", 3,10,00)
    course

    factory :session_with_section do
      section
      course { section.course }
    end
  end

  factory :reference do
    sequence(:title) { |n| "new article #{n}" }
    # date    Time.new(1979)
    # medium  "print"
    # pages   "100-200"
    # after(:build) do |reference|
    #   reference.authors = build_list(:author, 1)
    #   reference.translators = build_list(:author, 2)
    #   reference.editors = build_list(:author, 2)
    #   reference.meetings = build_list(:meeting, 3)
    #   reference.site_articles << build_list(:article, 4)
    # end
  end

  factory :monograph do
    title "New Monograph"
    after(:build) do |reference|
      reference.authors = [build(:author)]
      reference.translators = build_list(:author, 2)
      reference.editors = build_list(:author, 3)
      reference.sessions = build_list(:session, 4)
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
        reference.editors = [build(:williams)]
        reference.publisher = build(:cambridge_university_press)
      end
    end
  end

  factory :journal do
    sequence(:name) { |n| "new journal #{n}" }
    medium  "print"
    publisher
  end

  factory :magazine do
    sequence(:name) { |n| "new magazine #{n}" }
    medium  "print"
  end

  factory :chapter do
    title "New Chapter"
    pages "100-200"
    monograph
    
    factory :rhizome do
      title "Rhizome"
      pages "3-25"
      after(:build) do |reference|
        reference.monograph = build(:a_thousand_plateaus)
      end
    end

    factory :preface do
      title "Preface to the Second Edition"
      pages "3-9"
      after(:build) do |reference|
        reference.monograph = build(:the_gay_science)
      end
    end
  end

  factory :journal_article do
    sequence(:title) { |n| "new journal article #{n}" }
    publication_date    Time.new(1971)
    journal
    pages "100-200"
  end

  factory :magazine_article do
    sequence(:title) { |n| "new magazine article #{n}" }
    publication_date    Time.new(1991)
    magazine
    pages "100-200"
  end

  factory :author do
    first_name  "Jane"
    # middle_name "H."
    sequence(:last_name) { |n| "#{n}-Doe" }

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

    factory :nauckhoff do
      first_name "Josefine"
      last_name "Nauckhoff"
    end

    factory :del_caro do
      first_name "Adrian"
      last_name "Del Caro"
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

    factory :minneapolis_university_press do
      name  "Minneapolis University Press"
      location "Minneapolis"
    end
  end
end