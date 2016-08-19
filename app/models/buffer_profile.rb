class BufferProfile < ActiveRecord::Base
	has_many :lists
	attr_accessor :active

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
