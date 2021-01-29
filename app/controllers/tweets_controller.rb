class TweetsController < ApplicationController

  get('/tweets') {
    redirect '/login' unless Helpers.logged_in?(session)
    @tweets = Tweet.all
    erb :'tweets/tweets'
  }

  patch('/tweets') {
    content = params[:content]
    tweet_id = params[:tweet_id]
    redirect "/tweets/#{tweet_id}/edit" if content.empty?
    tweet = Tweet.find(tweet_id)
    tweet.content = content
    tweet.save
  }

  delete('/tweets') {
    tweet = Tweet.find(params[:tweet_id])
    tweet.destroy if tweet.user_id == Helpers.current_user(session).id
  }

  post('/tweets') {
    user_id = Helpers.current_user(session).id
    content = params[:content]
    if content.empty?
      redirect '/tweets/new'
    else
      tweet = Tweet.create(content: content, user_id: user_id) 
      # redirect "/tweets/#{tweet.id}"
    end
  }

  get('/tweets/new') {
    @logged_in = Helpers.logged_in?(session)
    redirect '/login' unless @logged_in
    erb :'tweets/new'
  }

  get('/tweets/:id/edit') {
    redirect '/login' unless Helpers.logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  }

  get('/tweets/:id') {
    redirect '/login' unless Helpers.logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  }
end
