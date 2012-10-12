class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def syllabus
    @course = Course.find(params[:id])
    @sections = @course.sections
  end
end