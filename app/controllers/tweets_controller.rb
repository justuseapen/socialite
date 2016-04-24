class TweetsController < ApplicationController
	def index
		list = List.find(params[:list_id])
		@tweets = list.top_tweets(params[:quality_percentage])
	end
	private
	def params
		params.require(:tweets).permit(:quality_percentage, :list_id)
	end
	
end