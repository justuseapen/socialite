class ListsController < ApplicationController
	include ListsHelper
	before_action :authenticate_user!, :buffer_connected?
	before_action :check_for_profiles, only: [:index]
	
	def index
		@buffer_profiles = current_user.buffer_profiles unless nil
		@lists = current_user.lists unless nil
	end

	def new
		@list = List.new
	end

	def create
		@user = current_user
		@buffer_profile = BufferProfile.find(list_params['buffer_profile'].to_i)
		@list = List.create(name:list_params['name'],
			buffer_profile:@buffer_profile,
			user: @user)
		if @list.save
			flash[:success] = "You've made a new list!"
			redirect_to lists_path
		else
			flash[:failure] = "Something went wrong"
			redirect_to new_list_path
		end
	end

	def show
		@list = List.find(params[:id])
		@buffer_profile = @list.buffer_profile
		respond_to do |format|
			format.json { render  :json => { list: @list.to_json } }
			format.html
		end
	end

	def destroy
		@list = List.find(params[:id])
		@list.destroy
		flash[:success] = "You've removed #{@list.name}!"
		redirect_to lists_path
	end

	private
	def list_params
		params.require(:list).permit(:name, :buffer_profile)
	end
end