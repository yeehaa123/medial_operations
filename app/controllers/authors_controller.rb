class AuthorsController < ApplicationController
  expose(:authors)
  expose(:author)
  expose(:references) { author.references }
end
