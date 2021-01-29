class TweetsController < ApplicationController

  get('/tweets') {
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  }
end
