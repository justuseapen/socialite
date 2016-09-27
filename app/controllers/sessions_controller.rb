class SessionsController < Devise::SessionsController
	def new
		super
	end
	def create
		params[:user].merge!(remember_me: 1)
		super
	end
	def destroy
		super
	end
end
