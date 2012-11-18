class CoursesController < ApplicationController
  expose(:course)
  expose(:sections) { course.sections }
  expose(:meetings) { course.meetings }

  def show
  end
end
