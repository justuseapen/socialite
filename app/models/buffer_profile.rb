class BufferProfile < ActiveRecord::Base
	has_many :lists
	belongs_to :buffer_account
	validates :buffer_account_id, presence: true
	attr_accessor :active

	def client
		buffer_account.client
	end

	def update_queue_with(tweetIds)
		puts "updating buffer queue"
		updates = []
		successful_updates = []
		failed_updates = []
		tweets = $twitter.statuses(tweetIds)
		tweets.each do |tweet|
			puts "buffering #{ tweet.text }"
			if tweet.media[0].blank?
				media_url = ""
			else
				media_url = tweet.media[0].media_url
			end
			update = client.create_update(
				body:{
					text: tweet.text,
					media: media_url,
					profile_ids:[ buffer_id ]
				}
			)
			updates << update
			if update.success?
				successful_updates << update
			else
				failed_updates << update
			end
		end
		response = {
			successful_updates: successful_updates,
			failed_updates: failed_updates
		}
	end

end
