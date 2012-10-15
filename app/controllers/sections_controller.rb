class SectionsController < ApplicationController  
  
  def show
    @section = Section.find(params[:id])
    @course  = @section.course
    @sessions = @section.sessions
  end

end