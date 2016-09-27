class BufferAccount < ActiveRecord::Base
	belongs_to :user
	after_save :pull_and_save_profiles
	has_many :buffer_profiles
	validates :access_token, presence: true
	validates :uid, presence: true

	def pull_and_save_profiles
		profiles = pull_profiles
		profiles.each do |p| 
			p.buffer_account_id = self.id
			p.save
		end
	end

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
