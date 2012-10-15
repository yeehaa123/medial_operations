class SessionsController < ApplicationController
  
  def show
    @session = Session.find(params[:id])
    @course  = @session.course
    @section = @session.section
  end

end
