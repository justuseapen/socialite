class BufferAccount < ActiveRecord::Base
	belongs_to :user
	before_save :pull_and_save_profiles
	has_many :buffer_profiles
	validates :access_token, presence: true
	validates :uid, presence: true
	validates :user_id, presence: true

	# So that we can save profiles from buffer
  def sanitized_profile_parameters(from_buffer)
  	serialized_profile_parameters = {
  		buffer_account_id: self.id,
  		buffer_id: from_buffer.id,
  		formatted_username: from_buffer.formatted_username,
  		avatar_url: from_buffer.avatar,
  	}
  end
	
# Do this on account creation
	def pull_and_save_profiles
		profiles = pull_profiles
		profiles.each do |p| 
			BufferProfile.find_or_create_by(sanitized_profile_parameters(p))
		end
	end

	# Buffer API Client
	def client
    Buffer::Client.new(self.access_token)
  end

  # Gets available buffer profiles that list "twitter as service"
  def pull_profiles
  	profiles_from_api = self.client.profiles
		profiles_array = []
		profiles_from_api.each do |p|
			if p.service == "twitter"
				profiles_array << p
			end
		end
		profiles_array
  end

end
