# Authors ---------------------------------------------------------------------

Author.create(first_name: "Chris", last_name: "Anderson")
Author.create(first_name: "Hannah", last_name: "Arendt")
Author.create(first_name: "Walter", last_name: "Benjamin")
Author.create(first_name: "Michel", particle: 'de', last_name: "Certeau")
Author.create(first_name: "Gilles", last_name: "Deleuze")
Author.create(first_name: "Felix", last_name: "Guattari")
Author.create(first_name: "Martin", last_name: "Heidegger")
Author.create(first_name: "Friedrich", last_name: "Kittler")
Author.create(first_name: "Rem", last_name: "Koolhaas")
Author.create(first_name: "Steven", last_name: "Levy")
Author.create(first_name: "Friedrich", last_name: "Nietzsche")

Author.create(first_name: "Uni", last_name: "Versal")

# Editors

Author.create(first_name: "Bernard", last_name: "Williams")
Author.create(first_name: "Marcus Paul", last_name: "Bullock")
Author.create(first_name: "Michael William", last_name: "Jennings")

# Translators

Author.create(first_name: "Josefine", last_name: "Nauckhoff")
Author.create(first_name: "Adrian", last_name: "Del Caro")
Author.create(first_name: "R. J.", last_name: "Hollingdale")
Author.create(first_name: "William", last_name: "Lovitt")


# Publisher -------------------------------------------------------------------

Publisher.create(name: "Cambridge University Press", location: "Cambridge")
Publisher.create(name: "Harvard University Press", location: "Cambridge, MA")
Publisher.create(name: "The University of Chicago Press", location: "Chicago")
Publisher.create(name: "University of California Press", location: "Berkeley")
Publisher.create(name: "University of Minnesota Press", location: "Minneapolis")

Publisher.create(name: "Annoying", location: "Amsterdam")


# References ------------------------------------------------------------------

# Monographs

Monograph.create(title: "One-Way Street",
                 authors: [Author.find_by(last_name: "Benjamin")],
                 # editors: [Author.find_by(last_name: "Bullock"),
                 #           Author.find_by(last_name: "Jennings")],
                 publication_date: Date.new(1996),
                 medium: "print",
                 publisher: Publisher.find_by(location: "Cambridge, MA"))

Monograph.create(title: "The Practice of Everyday Life",
                 authors: [Author.find_by(last_name: "Certeau")],
                 publication_date: Date.new(1984),
                 medium: "print",
                 publisher: Publisher.find_by(location: "Berkeley"))

Monograph.create(title: "A Thousand Plateaus",
                          authors: [Author.find_by(last_name: "Deleuze"),
                                    Author.find_by(last_name: "Guattari")],
                          publisher: Publisher.find_by(location: "Minneapolis"),
                          publication_date: Time.new(1987),
                          medium: "print")

Monograph.create(title: "The Question Concerning Technology",
                          authors: [Author.find_by(last_name: "Heidegger")],
                          translators: [Author.find_by(last_name: "Lovitt")],
                          publication_date: Time.new(1977),
                          medium: "print",
                          publisher: Publisher.find_by(location: "Cambridge"))

Monograph.create(title: "The Gay Science",
                          authors: [Author.find_by(last_name: "Nietzsche")],
                          # editors: [Author.find_by(last_name: "Williams")],
                          translators: [Author.find_by(last_name: "Nauckhoff"),
                                        Author.find_by(last_name: "Del Caro")],
                          publication_date: Time.new(2001),
                          medium: "print",
                          publisher: Publisher.find_by(location: "Cambridge"))

Monograph.create(title: "Human, All Too Human",
                          authors: [Author.find_by(last_name: "Nietzsche")],
                          translators: [Author.find_by(last_name: "Hollingdale")],
                          publication_date: Time.new(1996),
                          medium: "print",
                          publisher: Publisher.find_by(location: "Cambridge"))

Monograph.create(title: "Everything Ever Written",
                          authors: [Author.find_by(last_name: "Versal")],
                          publication_date: Time.new(2012),
                          medium: "print",
                          publisher: Publisher.find_by(name: "Annoying"))

# Chapters

Chapter.create(title: "The Age of the World Picture",
                        monograph: Monograph.find_by(title: "The Question Concerning Technology"),
                        publication_date: Time.new(1938),
                        pages: "115-155")

Chapter.create(title: "To the Planetarium",
                        monograph: Monograph.find_by(title: "One-Way Street"),
                        publication_date: Time.new(1928),
                        pages: "486-487")

Chapter.create(title: "Spatial Stories",
                        monograph: Monograph.find_by(title: "The Practice of Everyday Life"),
                        publication_date: Time.new(1984),
                        pages: "115-130")

Chapter.create(title: "Rhizome",
                        monograph: Monograph.find_by(title: "A Thousand Plateaus"),
                        publication_date: Time.new(1987),
                        pages: "3-25")

Chapter.create(title: "Future of Science",
                        monograph: Monograph.find_by(title: "Human, All Too Human"),
                        publication_date: Time.new(1928),
                        medium: "Print",
                        pages: "119")

Chapter.create(title: "Preface to the Second Edition",
                        monograph: Monograph.find_by(title: "The Gay Science"),
                        publication_date: Time.new(1928),
                        medium: "Print",
                        pages: "3-9")


Chapter.create(title: "What is Metaphyics?",
                        monograph: Monograph.last,
                        publisher: Publisher.first,
                        publication_date: Time.new(1929),
                        medium: "Print")

Chapter.create(title: "On Revolution",
                        monograph: Monograph.last,
                        publisher: Publisher.first,
                        publication_date: Time.new(1970),
                        medium: "Print")

Chapter.create(title: "Vita Activa",
                        monograph: Monograph.last,
                        publisher: Publisher.first,
                        publication_date: Time.new(1950),
                        medium: "Print")

Chapter.create(title: "Grammophone, Film, Typewriter",
                        monograph: Monograph.last,
                        publisher: Publisher.first,
                        publication_date: Time.new(1984),
                        medium: "Print")

Chapter.create(title: "Kafka. Towards a Minor Literature",
                        monograph: Monograph.last,
                        publisher: Publisher.first,
                        publication_date: Time.new(1974),
                        medium: "Print")


# COURSE ----------------------------------------------------------------------

course_description = <<END
Nowadays, computers are literally everywhere. Through heterogeneous interfaces
- such as sensors, transistors, and servo motors - they are inextricably
linked our spaces and bodies. It has therefore become almost impossible to
analyze cultural objects independent of their technological apparatus.
Nevertheless, scholars in the humanities are reluctant to learn about the hard-,
wet-, and software of art, literature, culture, and politics.

In this course we will modestly attempt to compensate for our discipline's
technological illiteracy and research the following question:

> What kind of approaches, methods and techniques are needed to analyze the
technical dimension of contemporary cultural objects?

Rather than approaching this question from a purely theoretical perspective, we
will learn to code ourselves. Programming, however, is not a goal in
itself but only a means to an end. We treat code as a particular form of
knowledge organization. Our goal is not to become full-time programmers, but to
gain an extra tool to pursue our research.
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
               # references: [Reference.find_by(title: "To the Planetarium"),
               #              Reference.find_by(title: "Future of Science")],
               publication_datetime: Time.now,
               location: "Bungehuis 4.01")

Session.create!(title: "Lecture", 
                section: Section.find_by(title: "Mapping The Humanities"),
                course: Course.first,
                description: session_description,
                # references: [Reference.find_by(title: "The Age of the World Picture"),
                #              Reference.find_by(title: "Universities: Wet, Hard, Soft, and Harder"),
                #              Reference.find_by(title: "How Google's Algorithm Rules the Web"),
                #              Reference.find_by(title: "The End of Theory: The Data Deluge Makes the Scientific Method Obsolete")],
                publication_datetime: Time.now + 1.weeks,
                location: "Bungehuis 4.01")

Session.create(title: "Lecture", 
               section: Section.find_by(title: "Mapping The Humanities"),
               course: Course.first,
               description: session_description,
               # references: [Reference.find_by(title: "Preface to the Second Edition"),
               #              Reference.find_by(title: "Spatial Stories"),
               #              Reference.find_by(title: "Rhizome"),
               #              Reference.find_by(title: "7 Essential Skills You Didn't Learn in College")],
               publication_datetime: Time.now + 2.weeks,
               location: "Bungehuis 4.01")


8.times do |count|
  c = count + 4
  case c
  when 4..8
    Session.create(title: "Test #{ c }", 
                   section: Section.find_by(title: "F(r)ictions and/or (Fr)Actions of the Imaginary"),
                   course: Course.first,
                   description: session_description,
                   publication_datetime: Time.now + c.weeks,
                   location: "Bungehuis 4.01")
  when 9..12
    Session.create(title: "Test #{ c }", 
                   section: Section.find_by(title: "The Eternal Recurrence of Body Snatchers"), 
                   course: Course.first,
                   description: session_description,
                   publication_datetime: Time.now + c.weeks,
                   location: "Bungehuis 4.01")
  end
end