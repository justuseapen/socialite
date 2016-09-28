class BufferProfile < ActiveRecord::Base
	

	# Buffer Profile
	# ==============
	# buffer_account_id : integer
	# formatted_username : string
	# buffer_id : string
	# avatar_url : string


	has_many :lists
	belongs_to :buffer_account
	has_one :user, through: :buffer_account
	validates :buffer_account_id, presence: true
	validates :formatted_username, presence: true
	validates :buffer_id, presence: true
	validates :avatar_url, presence: true

	def client
		buffer_account.client
	end

	# Change to "updates"
	def update_queue_with(tweetIds)
		puts "updating buffer queue"
		updates = []
		successful_updates = []
		failed_updates = []
		# pulls tweets with given ids
		tweets = $twitter.statuses(tweetIds)
		# buffers each tweet
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
					media: {
						photo:media_url
						},
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
