FactoryGirl.define do

  factory :course do
    title   "New Course"
    description   "Hello *World*"
    title_prefix  "12345"
    # after(:build) do |course|
    #   5.times { course.references << build(:reference) }
    # end
  end
  
  factory :section do
    title   "New Section"
    sequence(:number) { |n| n }
    course
    description "Hello *World*"
  end  
  
  factory :session do
    title     "New Session"
    datetime  Time.now
    location  "Bungehuis 4.01"
    section
    course { section.course }
  end
end