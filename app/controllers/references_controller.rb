class ReferencesController < ApplicationController
  expose(:references)
  expose(:reference_search) { Reference.fulltext_search(params[:query]) }
  expose(:reference) { Reference.find(params[:id]) }

  def show
  end

  def index
  end
end
