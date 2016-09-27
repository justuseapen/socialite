class BufferProfilesController < ApplicationController
	
	def new
		@buffer_account = current_user.buffer_account
		@buffer_profiles = current_user.buffer_profiles
		@inactive_buffer_profiles
	end

	def create
		byebug
		p = BufferProfile.create(profile_params)
		if p.save
			flash[:success] = "You've added #{ p.formatted_username }!"
			redirect_to new_buffer_profiles_path
		else
			flash[:alert] = "Something went wrong :/"
			redirect_to new_buffer_profiles_path
		end
	end

	def show
		flash[:failure] = "Bug!"
		redirect_to new_buffer_profiles_path
	end

	def destroy
		@buffer_profile = BufferProfile.find(params[:id])
		@buffer_profile.destroy
		flash[:success] = "You've removed #{ @buffer_profile.formatted_username }!"
		redirect_to action: :new
	end

	private

	def profile_params
		params.permit(:formatted_username, :buffer_id, :id, :buffer_account_id)
	end

end
