class ListsController < ApplicationController
	def index
		@lists = List.all unless nil
		@buffer_profiles = BufferProfile.all unless nil
	end

	def new
		@list = List.new
	end

	def create
		@list = List.create(list_params)
		redirect_to lists_path
	end

	def show
		@list = List.find(params[:id])
		respond_to do |format|
			format.json { render  :json => { list: @list.to_json } }
			format.html
		end
	end

	private
	def list_params
		params.require(:list).permit(:name)
	end
end