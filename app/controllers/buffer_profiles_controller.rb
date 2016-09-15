class BufferProfilesController < ApplicationController
	def new
		@buffer_profiles = BufferProfile.pull
	end
	def create
		p = BufferProfile.create(profile_params)
		if p.save
			flash[:success] = "You've added #{p.formatted_username}!"
			redirect_to new_buffer_profiles_path
		end
	end
	def destroy
		@buffer_profile = BufferProfile.find(params[:id])
		@buffer_profile.destroy
		flash[:success] = "You've removed #{@buffer_profile.formatted_username}!"
		redirect_to action: :new
	end
	private
	def profile_params
		params.permit(:formatted_username, :buffer_id, :id)
	end
end