class List < ActiveRecord::Base
	has_many :twitter_accounts
	belongs_to :buffer_profile

	def top_tweets(percentage_integer)
		tweets = []
		twitter_accounts.each do |ta|
			tweets << ta.top_tweets(percentage_integer)
		end
	end
end
