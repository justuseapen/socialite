class UpdatesController < ApplicationController
	def create
		@list = List.find(params['listId'])
		@buffer_profile = BufferProfile.find(@list.buffer_profile_id)
		tweetIds = params['tweetIds']
		response = @buffer_profile.update_queue_with(tweetIds)
		respond_to do |format|
			format.json { render  :json => response }
		end
	end
end