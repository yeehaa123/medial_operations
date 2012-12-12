class SectionsController < ApplicationController
  expose(:section)
  expose(:course)      { section.course }
  expose(:sessions)    { section.sessions }
  expose(:assignments) { section.assigments }

  def show
  end

end
