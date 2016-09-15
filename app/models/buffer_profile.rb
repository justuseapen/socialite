class BufferProfile < ActiveRecord::Base
	has_many :lists
	attr_accessor :active

	def update_queue_with(tweetIds)
		puts "updating buffer queue"
		updates = []
		successful_updates = 0
		failed_updates = 0
		tweets = $twitter.statuses(tweetIds)
		tweets.each do |tweet|
			puts "buffering #{ tweet.text }"
			update = $buffer.create_update(
				body:{
					text: tweet.text,
					profile_ids:[ buffer_id ]
				}
			)
			updates << update
			if update.success?
				successful_updates += 1
			else
				failed_updates += 1
			end
		end
		response = {
			updates: updates,
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
