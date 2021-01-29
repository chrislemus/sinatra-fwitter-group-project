class UsersController < ApplicationController

  get('/users/:slug') {
    user = User.find_by(slug: params[:slug])   
    @tweets = user.tweets 
    erb :'users/show'
  }


end
