class CoursesController < ApplicationController

  def show
    @course = Course.find(params[:id])
  end

  def syllabus
    @course = Course.find(params[:id])
    @sections = @course.sections
    @sessions = @course.sessions
  end

end