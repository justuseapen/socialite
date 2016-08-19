class TweetsController < ApplicationController
	def index
		puts "PARAMS: #{params.inspect}"
		list = List.find(params[:tweets][:list])
		@tweets = list.top_tweets(params[:tweets][:quality_percentage])
		respond_to do |format|
			format.json { render  :json => { tweets: @tweets.to_json } }
		end
	end
end
