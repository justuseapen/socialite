module ListsHelper
	def buffer_connected?
		if current_user.buffer_connected?
			return true
		else
			redirect_to new_buffer_connection_path
		end
	end

	def check_for_profiles
		if current_user.buffer_profiles.count < 1
		end
	end

end