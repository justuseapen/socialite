class CallbacksController < Devise::OmniauthCallbacksController
	def buffer
		@user = current_user
	  @user.connect_with_buffer(request.env["omniauth.auth"])
	  if @user.buffer_connected?
	  	redirect_to root_path
	  else
	  	flash[:failure] = "Something went wrong, try again."
	  	redirect_to new_buffer_connection_path
	  end
	end
end
