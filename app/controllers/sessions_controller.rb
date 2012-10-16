class SessionsController < ApplicationController
  expose(:session)
  expose(:course)  { session.course }
  expose(:section) { session.section }
  
  def show
  end

end
