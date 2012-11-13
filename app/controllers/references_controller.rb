class ReferencesController < ApplicationController
  expose(:references) { Reference.search(params) }
  expose(:reference)  { Reference.find(params[:id]) }

  def show
  end

  def index
  end
end
