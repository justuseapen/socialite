class ListsController < ApplicationController
	def index
		@lists = List.all unless nil
		@buffer_profiles = BufferProfile.all unless nil
	end

	def new
		@list = List.new
	end

	def create
		@buffer_profile = BufferProfile.find(list_params['buffer_profile'].to_i)
		@list = List.create(name:list_params['name'],buffer_profile:@buffer_profile)
		redirect_to lists_path
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