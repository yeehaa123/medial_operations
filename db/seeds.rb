parser = CourseParser.new
syllabus = IO.read(Rails.root.join("db", "medial_operations.html"))
parser.parse_course(syllabus)
#
#
# # Authors ---------------------------------------------------------------------
# 
# Author.create(first_name: "Chris", last_name: "Anderson")
# Author.create(first_name: "Martin", last_name: "Heidegger")
# Author.create(first_name: "Friedrich", last_name: "Kittler")
# Author.create(first_name: "Rem", last_name: "Koolhaas")
# Author.create(first_name: "Steven", last_name: "Levy")
# Author.create(first_name: "Friedrich", last_name: "Nietzsche")
# 
# # Editors
# 
# Author.create(first_name: "Bernard", last_name: "Williams")
# 
# # Translators
# 
# Author.create(first_name: "Josefine", last_name: "Nauckhoff")
# Author.create(first_name: "Adrian", last_name: "Del Caro")
# Author.create(first_name: "R. J.", last_name: "Hollingdale")
# Author.create(first_name: "William", last_name: "Lovitt")
# 
# 
# # Publisher -------------------------------------------------------------------
# 
# Publisher.create(name: "Cambridge University Press", location: "Cambridge")
# Publisher.create(name: "The University of Chicago Press", location: "Chicago")
# Publisher.create(name: "University of California Press", location: "Berkeley")
# Publisher.create(name: "University of Minnesota Press", location: "Minneapolis")
# 
# 
# # References ------------------------------------------------------------------
# 
# # Monographs
# 
# Monograph.create(title: "One-Way Street",
#                  authors: [Author.find_or_create_by(first_name: "Walter", 
#                                                     last_name: "Benjamin")],
#                  editors: [Author.find_or_create_by(first_name: "Marcus Paul", 
#                                                     last_name: "Bullock"),
#                            Author.find_or_create_by(first_name: "Michael William", 
#                                                     last_name: "Jennings")],
#                  publication_date: Date.new(1996),
#                  medium: "print",
#                  publisher: Publisher.find_or_create_by(name: "Harvard University Press", 
#                                                         location: "Cambridge, MA"))
# 
# Monograph.create(title: "The Practice of Everyday Life",
#                  authors: [Author.find_or_create_by(first_name: "Michel",
#                                                     particle: "de",
#                                                     last_name: "Certeau")],
#                  publication_date: Date.new(1984),
#                  medium: "print",
#                  publisher: Publisher.find_by(location: "Berkeley"))
# 
# Monograph.create(title: "A Thousand Plateaus",
#                  authors: [Author.find_or_create_by(first_name: "Gilles",
#                                                     last_name: "Deleuze"),
#                            Author.find_or_create_by(first_name: "Felix",
#                                                     last_name: "Guattari")],
#                  publisher: Publisher.find_by(location: "Minneapolis"),
#                  publication_date: Time.new(1987),
#                 medium: "print")
# 
# Monograph.create(title: "The Question Concerning Technology",
#                  authors: [Author.find_by(last_name: "Heidegger")],
#                  translators: [Author.find_by(last_name: "Lovitt")],
#                  publication_date: Time.new(1977),
#                  medium: "print",
#                  publisher: Publisher.find_by(location: "Cambridge"))
# 
# Monograph.create(title: "The Gay Science",
#                  authors: [Author.find_by(last_name: "Nietzsche")],
#                  editors: [Author.find_by(last_name: "Williams")],
#                  translators: [Author.find_by(last_name: "Nauckhoff"),
#                                Author.find_by(last_name: "Del Caro")],
#                  publication_date: Time.new(2001),
#                  medium: "print",
#                  publisher: Publisher.find_by(location: "Cambridge"))
# 
# Monograph.create(title: "Human, All Too Human",
#                  authors: [Author.find_by(last_name: "Nietzsche")],
#                  translators: [Author.find_by(last_name: "Hollingdale")],
#                  publication_date: Time.new(1996),
#                  medium: "print",
#                  publisher: Publisher.find_by(location: "Cambridge"))
# 
# # Journals
# 
# Journal.create(name: "Critical Inquiry",
#                publisher: Publisher.find_by(location: "Chicago"),
#                medium: "print")
# 
# # Magazines
# 
# Magazine.create(name: "Wired", medium: "print")
# 
# 
# # Chapters
# 
# Chapter.create(title: "The Age of the World Picture",
#                monograph: Monograph.find_by(title: "The Question Concerning Technology"),
#                publication_date: Time.new(1938),
#                startpage: 115,
#                endpage: 155,
#                tags: %w[mathematics science technology])
# 
# Chapter.create(title: "To the Planetarium",
#                monograph: Monograph.find_by(title: "One-Way Street"),
#                publication_date: Time.new(1928),
#                startpage: 486,
#                endpage: 487,
#                tags: %w[astronomy astrology science planetarium technology architecture])
# 
# Chapter.create(title: "Spatial Stories",
#                monograph: Monograph.find_by(title: "The Practice of Everyday Life"),
#                publication_date: Time.new(1984),
#                startpage: 115,
#                endpage: 130,
#                tags: %w[space tactics strategy practice architecture narratives])
# 
# Chapter.create(title: "Rhizome",
#                monograph: Monograph.find_by(title: "A Thousand Plateaus"),
#                publication_date: Time.new(1987),
#                startpage: 3,
#                endpage: 25,
#                tags: %w[space biology practice art brain])
# 
# Chapter.create(title: "Future of Science",
#                monograph: Monograph.find_by(title: "Human, All Too Human"),
#                publication_date: Time.new(1928),
#                medium: "Print",
#                startpage: 119,
#                endpage: 119,
#                tags: %w[brain science university practice art])
# 
# Chapter.create(title: "Preface to the Second Edition",
#                monograph: Monograph.find_by(title: "The Gay Science"),
#                publication_date: Time.new(1928),
#                medium: "Print",
#                startpage: 3,
#                endpage: 9,
#                tags: %w[sickness science art practice])
# 
# 
# # Magazine Articles
# 
# MagazineArticle.create(title: "How Google's Algorithm Rules the Web",
#                        authors: [Author.find_by(last_name: "Levy")],
#                        magazine: Magazine.find_by(name: "Wired"),
#                        url: "http://www.wired.com/magazine/2010/02/ff_google_algorithm/",
#                        volume: 16,
#                        issue:  07,
#                        publication_date: Time.new(2010, 2, 22),
#                        tags: %w[algorithm google mathematics law])
# 
# MagazineArticle.create(title: "The End of Theory: The Data Deluge Makes the Scientific Method Obsolete",
#                        authors: [Author.find_by(last_name: "Anderson")],
#                        magazine: Magazine.find_by(name: "Wired"),
#                        url: "http://www.wired.com/science/discoveries/magazine/16-07/pb_intro",
#                        volume: 17,
#                        issue:  12,
#                        publication_date: Time.new(2008, 8, 23),
#                        tags: %w[science humanities algorithm data data-visualization])
# 
# MagazineArticle.create(title: "The New World: 30 Spaces for the 21st Century",
#                        authors: [Author.find_by(last_name: "Koolhaas")],
#                        magazine: Magazine.find_by(name: "Wired"),
#                        url: "http://www.wired.com/wired/archive/11.06/newworld.html",
#                        volume: 11,
#                        issue:  06,
#                        publication_date: Time.new(2003, 6),
#                        tags: %w[space architecture data data-visualization])
# 
# MagazineArticle.create(title: "7 Essential Skills You Didn't Learn in College",
#                        magazine: Magazine.find_by(name: "Wired"),
#                        url: "http://www.wired.com/magazine/2010/09/ff_wiredu/all/1",
#                        volume: 18,
#                        issue:  10,
#                        publication_date: Time.new(2003, 9, 27),
#                        tags: %w[practice university data data-visualization])
# 
# 
# # Journal Articles
# 
# JournalArticle.create(title: "Universities: Wet, Hard, Soft, and Harder",
#                       authors: [Author.find_by(last_name: "Kittler")],
#                       journal: Journal.find_by(name: "Critical Inquiry"),
#                       url: "http://www.jstor.org/stable/10.1086/427310",
#                       startpage: 244,
#                       endpage: 255,
#                       volume: 31,
#                       issue: 1,
#                       publication_date: Time.new(2004))
# 
# 
# 
# # COURSE ----------------------------------------------------------------------
# 
# course_description = <<END
# Nowadays, computers are literally everywhere. Through heterogeneous interfaces
# - such as sensors, transistors, and servo motors - they are inextricably
# linked our spaces and bodies. It has therefore become almost impossible to
# analyze cultural objects independent of their technological apparatus.
# Nevertheless, scholars in the humanities are reluctant to learn about the hard-,
# wet-, and software of art, literature, culture, and politics.
# 
# In this course we will modestly attempt to compensate for our discipline's
# technological illiteracy and research the following question:
# 
# > What kind of approaches, methods and techniques are needed to analyze the
# technical dimension of contemporary cultural objects?
# 
# Rather than approaching this question from a purely theoretical perspective, we
# will learn to code ourselves. Programming, however, is not a goal in
# itself but only a means to an end. We treat code as a particular form of
# knowledge organization. Our goal is not to become full-time programmers, but to
# gain an extra tool to pursue our research.
# END
# 
# 
# Course.create(title_prefix: "Art, Science, and Technology",
#               title: "Medial Operations",
#               description: course_description)
# 
# 
# # SECTIONS --------------------------------------------------------------------
# 
# section_1_description = <<END
# In this course we will modestly attempt to compensate for our discipline's
# technological illiteracy and research the following question:
# 
# > What kind of approaches, methods and techniques are needed to analyze the
# technical dimension of contemporary cultural objects?
# 
# Nowadays, computers are literally everywhere. Through heterogeneous interfaces
# - such as sensors, transistors, and servo motors - they are inextricably
# linked our spaces and bodies.
# END
# 
# section_2_description = <<END
# In this course we will modestly attempt to compensate for our discipline's
# technological illiteracy and research the following question:
# 
# > What kind of approaches, methods and techniques are needed to analyze the
# technical dimension of contemporary cultural objects?
# 
# Nowadays, computers are literally everywhere. Through heterogeneous interfaces
# - such as sensors, transistors, and servo motors - they are inextricably
# linked our spaces and bodies.
# END
# 
# section_3_description = <<END
# In this course we will modestly attempt to compensate for our discipline's
# technological illiteracy and research the following question:
# 
# > What kind of approaches, methods and techniques are needed to analyze the
# technical dimension of contemporary cultural objects?
# 
# Nowadays, computers are literally everywhere. Through heterogeneous interfaces
# - such as sensors, transistors, and servo motors - they are inextricably
# linked our spaces and bodies.
# END
# 
# Section.create(title: "Mapping The Humanities",
#                course: Course.first,
#                description: section_1_description,
#                number: 1 )
# Section.create(title: "F(r)ictions and/or (Fr)Actions of the Imaginary",
#                course: Course.first,
#                description: section_2_description,
#                number: 2)
# Section.create(title: "The Eternal Recurrence of Body Snatchers",
#                course: Course.first,
#                description: section_3_description,
#                number: 3)
# 
# 
# # MeetingS --------------------------------------------------------------------
# 
# meeting_description = <<END
# Nowadays, computers are literally everywhere. Through heterogeneous interfaces
# - such as sensors, transistors, and servo motors - they are inextricably
# linked our spaces and bodies.
# END
# 
# Meeting.create(title: "Introduction", 
#                course: Course.first,
#                description: meeting_description,
#                references: [Reference.find_by(title: "To the Planetarium"),
#                             Reference.find_by(title: "Future of Science")],
#                datetime: Time.now,
#                location: "Bungehuis 4.01",
#                tags: %w[science art])
# 
# Meeting.create!(title: "Lecture", 
#                 section: Section.find_by(title: "Mapping The Humanities"),
#                 course: Course.first,
#                 description: meeting_description,
#                 references: [Reference.find_by(title: "The Age of the World Picture"),
#                              Reference.find_by(title: "Universities: Wet, Hard, Soft, and Harder"),
#                              Reference.find_by(title: "How Google's Algorithm Rules the Web"),
#                              Reference.find_by(title: "The End of Theory: The Data Deluge Makes the Scientific Method Obsolete")],
#                 datetime: Time.now + 1.weeks,
#                 location: "Bungehuis 4.01")
# 
# Meeting.create(title: "Lecture", 
#                section: Section.find_by(title: "Mapping The Humanities"),
#                course: Course.first,
#                description: meeting_description,
#                references: [Reference.find_by(title: "Preface to the Second Edition"),
#                             Reference.find_by(title: "Spatial Stories"),
#                             Reference.find_by(title: "Rhizome"),
#                             Reference.find_by(title: "7 Essential Skills You Didn't Learn in College")],
#                datetime: Time.now + 2.weeks,
#                location: "Bungehuis 4.01")
# 
# 
# 8.times do |count|
#   c = count + 4
#   case c
#   when 4..8
#     Meeting.create(title: "Test #{ c }", 
#                    section: Section.find_by(title: "F(r)ictions and/or (Fr)Actions of the Imaginary"),
#                    course: Course.first,
#                    description: meeting_description,
#                    datetime: Time.now + c.weeks,
#                    location: "Bungehuis 4.01")
#   when 9..1
#     Meeting.create(title: "Test #{ c }", 
#                    section: Section.find_by(title: "The Eternal Recurrence of Body Snatchers"), 
#                    course: Course.first,
#                    description: meeting_description,
#                    datetime: Time.now + c.weeks,
#                    location: "Bungehuis 4.01")
#   end
# end
# 
# 
# # Assignments -----------------------------------------------------------------
# 
# 3.times do |count|
#   c = count + 1 
#   Assignment.create(title: "Assignment #{ c }",
#                     course: Course.first,
#                     section: Section.find_by(number: c),
#                     description: "Assignment #{ c }",
#                     deadline: Time.now + c.months)
# end
