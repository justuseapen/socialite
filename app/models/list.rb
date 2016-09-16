class List < ActiveRecord::Base
	has_many :twitter_accounts
	belongs_to :buffer_profile
	validates :buffer_profile, presence: true

	# Pulls top tweets for whole list (many accounts)
	def top_tweets(percentage_integer)
		puts "Pulling top #{percentage_integer}% tweets"
		tweets = []
		twitter_accounts.each do |ta|
			# twitter_account.top_tweets pulls the top tweets for a given account
			tweets = tweets + ta.top_tweets(percentage_integer)
		end
		tweets
	end

end
