class ReferencesController < ApplicationController
  # expose(:references) do
  #   if params[:query].present?
  #     Reference.search(params[:query], type: nil, load: true)
  #   else
  #     Reference.all
  #   end
  # end
  # expose(:references) { Reference.search(params) }
  expose(:references) { Reference.all }
  expose(:reference)

  def show
  end

  def index
  end
end