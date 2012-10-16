class CoursesController < ApplicationController
  expose(:course)
  expose(:sections) { course.sections }
  expose(:sessions) { course.sessions }

  def show
  end
end