class ReferencesController < ApplicationController
  expose(:references) { Reference.search(params) }
  expose(:reference)

  def show
  end

  def index
  end
end