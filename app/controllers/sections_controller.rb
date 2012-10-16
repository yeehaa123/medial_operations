class SectionsController < ApplicationController
  expose(:section)
  expose(:course)  { section.course }
  expose(:sessions) { section.sessions }
  
  def show
  end

end