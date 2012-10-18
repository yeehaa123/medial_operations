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
    sequence(:title) { |n| "new monograph #{n}" }
    publication_date    Time.new(1979)
    medium  "print"
    after(:build) do |reference|
      reference.authors = build_list(:author, 1)
    #   reference.translators = build_list(:author, 2)
    #   reference.editors = build_list(:author, 2)
    #   reference.meetings = build_list(:meeting, 3)
    #   reference.site_articles << build_list(:article, 4)
    end
  end

  factory :chapter do
    sequence(:title) { |n| "new chapter #{n}" }
    publication_date    Time.new(1971)
    monograph
  end

  factory :author do
    first_name  "Jane"
    # middle_name "H."
    sequence(:last_name) { |n| "#{n}-Doe" }
  end
end


