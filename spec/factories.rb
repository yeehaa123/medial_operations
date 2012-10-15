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
    sequence(:title)  { |n| "New Session #{n}" }
    description       "Hello *World*"    
    sequence(:datetime) { |n| Time.zone.local(2013,"jan", n ,10,00) }
    location  "Bungehuis 4.01"
    course

    factory :session_with_section do
      section
      course { section.course }
    end
  end
end