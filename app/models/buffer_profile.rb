class BufferProfile < ActiveRecord::Base
	has_many :lists
	attr_accessor :active

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
			update = $buffer.create_update(
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

	# Gets current user's available buffer profiles that list "twitter as service"
	def self.pull
		profiles_from_api = $buffer.profiles
		profiles_array = []
		profiles_from_api.each do |p|
			if p.service == "twitter"
				p = BufferProfile.new(formatted_username: p.formatted_username, buffer_id: p.id)
				if BufferProfile.where(buffer_id: p.buffer_id).take.present?
					p = BufferProfile.where(buffer_id: p.buffer_id).take
					p.active = true
				else
					p.active = false
				end
				profiles_array << p
			end
		end
		profiles_array
	end

end
