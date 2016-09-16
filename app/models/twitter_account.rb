class TwitterAccount < ActiveRecord::Base
	belongs_to :list

	class Twitter::Tweet
		def score
			self.favorite_count + self.retweet_count
		end
	end

	# Retrieve account details from twitter
	def retrieve_account_details
		account = $twitter.user("#{self.handle}")
		self.name = account.name
		self.avatar_url = account.profile_image_uri
	end

	# Always gets tweets from last 48 hours.
	# If there are no tweets from the last two days
	# 	Pull all-time top tweets
	# 	You can pull up to 3200 tweets, 200 at a time per account
	# 	and rate limiting could (will) be an issue
	def top_tweets(percentage_integer)
		tweets = tweets_since(48.hours.ago)
		if tweets.length < 1
			tweets = last(200)
		end
		array_length = tweets.length
		perentage_float = percentage_integer.to_f / 100
		top_length = array_length.to_f * perentage_float
		ranked = ranked_by_score(tweets)
		tweets = ranked[0..top_length - 1]
	end

	def ranked_by_score(tweets_array)
		tweets_array.sort_by! {|tweet| -tweet.score }
	end

	def last(number_of_tweets)
		# Cache the the call for an hour to save time on regular useage.
		APICache.get('last', { cache: 3600, timeout: 10 }) do
			options = {count: number_of_tweets, include_rts: false, exclude_replies: true}
			$twitter.user_timeline(self.handle, options)
		end

	end

	# Gets tweets for an account since a given time.
	def tweets_since(datetime)
		# Cache the the call for an hour to save time on regular useage.
		APICache.get("tweets_since_for#{ self.handle }", { cache: 3600, timeout: 10 }) do
	  	tweets = []
			options = {count: 50, include_rts: false, exclude_replies: true}
			$twitter.user_timeline(self.handle, options).each do |t|
				if t.created_at > datetime
					tweets << t
				end
			end
			tweets
		end
	end

	def good_tweets_since(datetime)
		tweets = tweets_since(datetime)
		good_tweets = []
		tweets.each do |t|
			score = t.favorite_count + t.retweet_count
			if score > self.moving_average_score(100) + self.moving_standard_deviation(100)
				good_tweets << t
			end
		end
		good_tweets
	end

	def scores(number_of_scores)
		scores = []
		last(number_of_scores).each do |t|
			favs = t.favorite_count
			rts = t.retweet_count
			score = favs + rts
			scores << score
		end
		scores
	end

	def moving_average_score(series_length_integer)
		scores = scores(series_length_integer)
		ma = scores.inject{ |sum, el| sum + el }.to_f / scores.size
    return ma
	end

	def moving_standard_deviation(series_length_integer)
		ma = moving_average_score(series_length_integer)
		scores = scores(series_length_integer)
		sum = scores.inject(0){|accum, i| accum +(i-ma)**2 }
    variance = sum/(scores.length - 1).to_f
		Math.sqrt(variance)
	end

end
