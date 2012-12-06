class CoursesController < ApplicationController
  expose(:course)   { Course.first }
  expose(:sections) { course.sections }
  expose(:meetings) { course.meetings }

  def show
  end
end
