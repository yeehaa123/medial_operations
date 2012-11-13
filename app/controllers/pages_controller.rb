class PagesController < ApplicationController
  expose(:data_array) { Tag.all.sort(name: 1).to_json(methods: :count) } 
end
