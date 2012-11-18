class TagsController < ApplicationController
  expose(:tags) { Tag.all }
  expose(:taggie) { Tag.find(params[:id]) }
  expose(:references) { taggie.references }
  expose(:meetings)   { taggie.meetings }
end
