class UsersController < ApplicationController
  expose(:user) { User.find(params[:id]) }
end
