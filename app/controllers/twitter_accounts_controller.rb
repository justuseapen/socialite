class TwitterAccountsController < ApplicationController
	def new
		@list = List.find(params[:list_id])
		@twitter_account = TwitterAccount.new(list_id: @list.id)
	end

	def create
		@twitter_account = TwitterAccount.create(twitter_account_params)
		@list = @twitter_account.list_id
		redirect_to list_path(@list)
	end

	private
	def twitter_account_params
		params.require(:twitter_account).permit(:handle, :list_id)
	end
end