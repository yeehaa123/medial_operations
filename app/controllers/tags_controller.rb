class TagsController < ApplicationController
  expose(:tags) { Tag.all }
  expose(:taggie) { Tag.find(params[:id]) }
  expose(:references) { Reference.search(query: "#{ taggie }")}
  expose(:sessions)   { Session.search(query: "#{ taggie }")}
end