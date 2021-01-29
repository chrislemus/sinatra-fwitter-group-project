class UsersController < ApplicationController

  get('/users/:slug') {
    
    user = User.find_by_slug(params[:slug])   
    @tweets = user.tweets 
    binding.pry
    erb :'users/show'
  }


end
