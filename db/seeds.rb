# COURSE ----------------------------------------------------------------------

course_description = <<END
- such as sensors, transistors, and servo motors - they are inextricably 
linked our spaces and bodies. It has therefore become almost impossible to 
analyze cultural objects independent of their technological apparatus. 
Nevertheless, scholars in the humanities are reluctant to learn about the hard-, 
wet-, and software of art, literature, culture, and politics.

In this course we will modestly attempt to compensate for our discipline's 
technological illiteracy and research the following question:

> What kind of approaches, methods and techniques are needed to analyze the 
technical dimension of contemporary cultural objects?

END

Course.create(title_prefix: "Art, Science, and Technology",
              title: "Medial Operations", 
              description: course_description)


# SECTIONS --------------------------------------------------------------------

section_1_description = <<END
In this course we will modestly attempt to compensate for our discipline's 
technological illiteracy and research the following question:

> What kind of approaches, methods and techniques are needed to analyze the 
technical dimension of contemporary cultural objects?

Nowadays, computers are literally everywhere. Through heterogeneous interfaces 
- such as sensors, transistors, and servo motors - they are inextricably 
linked our spaces and bodies.
END

section_2_description = <<END
In this course we will modestly attempt to compensate for our discipline's 
technological illiteracy and research the following question:

> What kind of approaches, methods and techniques are needed to analyze the 
technical dimension of contemporary cultural objects?

Nowadays, computers are literally everywhere. Through heterogeneous interfaces 
- such as sensors, transistors, and servo motors - they are inextricably 
linked our spaces and bodies.
END

section_3_description = <<END
In this course we will modestly attempt to compensate for our discipline's 
technological illiteracy and research the following question:

> What kind of approaches, methods and techniques are needed to analyze the 
technical dimension of contemporary cultural objects?

Nowadays, computers are literally everywhere. Through heterogeneous interfaces 
- such as sensors, transistors, and servo motors - they are inextricably 
linked our spaces and bodies.
END

Section.create(title: "Mapping The Humanities",
               course: Course.first,
               description: section_1_description,
               number: 1)
Section.create(title: "F(r)ictions and/or (Fr)Actions of the Imaginary",
               course: Course.first,
               description: section_2_description,
               number: 2)
Section.create(title: "The Eternal Recurrence of Body Snatchers",
               course: Course.first,
               description: section_3_description,
               number: 3)


# SESSIONS --------------------------------------------------------------------

session_description = <<END
Nowadays, computers are literally everywhere. Through heterogeneous interfaces 
- such as sensors, transistors, and servo motors - they are inextricably 
linked our spaces and bodies.
END

Session.create(title: "Introduction", 
               course: Course.first,
               description: session_description,
               # references: [Reference.find_by_title("To the Planetarium"),
               #              Reference.find_by_title("Future of Science")],
               datetime: Time.now,
               location: "Bungehuis 4.01")

Session.create!(title: "Lecture", 
                section: Section.find_by(title: "Mapping The Humanities"),
                course: Course.first,
                description: session_description,
                # references: [Reference.find_by_title("The Age of the World Picture"),
                #              Reference.find_by_title("Universities: Wet, Hard, Soft, and Harder"),
                #              Reference.find_by_title("How Google's Algorithm Rules the Web"),
                #              Reference.find_by_title("The End of Theory: The Data Deluge Makes the Scientific Method Obsolete")],
                datetime: Time.now + 1.weeks,
                location: "Bungehuis 4.01")

Session.create(title: "Lecture", 
               section: Section.find_by(title: "Mapping The Humanities"),
               course: Course.first,
               description: session_description,
               # references: [Reference.find_by_title("Preface to the Second Edition"),
               #              Reference.find_by_title("Spatial Stories"),
               #              Reference.find_by_title("Rhizome"),
               #              Reference.find_by_title("The New World: 30 Spaces for the 21st Century"),
               #              Reference.find_by_title("7 Essential Skills You Didn't Learn in College")],
               datetime: Time.now + 2.weeks,
               location: "Bungehuis 4.01")


8.times do |count|
  c = count + 4
  case c
  when 4..8
    Session.create(title: "Test #{ c }", 
                   section: Section.find_by(title: "F(r)ictions and/or (Fr)Actions of the Imaginary"),
                   course: Course.first,
                   description: session_description,
                   datetime: Time.now + c.weeks,
                   location: "Bungehuis 4.01")
  when 9..12
    Session.create(title: "Test #{ c }", 
                   section: Section.find_by(title: "The Eternal Recurrence of Body Snatchers"), 
                   course: Course.first,
                   description: session_description,
                   datetime: Time.now + c.weeks,
                   location: "Bungehuis 4.01")
  end
end