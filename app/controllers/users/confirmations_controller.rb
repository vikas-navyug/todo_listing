#####################################################################
# Copyleft: Free for humanity
# Developer : Ranu Pratap Singh
# Email : singh.ranupratap@gmail.com
# Created Date : 22/07/14
#####################################################################

module Users
	class ConfirmationsController < Devise::ConfirmationsController
		# GET /auth/confirmation?confirmation_token=abcdef
		def show
			@user = User.confirm_by_token(params[:confirmation_token])
			if @user.errors.empty?
				sign_in @user
				redirect_to root_url
			else
				error_message = 'could not confirm the user'
				unless @user.errors[:confirmation_token].empty?
					error_message = 'The Confirmation Token is Invalid'
				end
				render :json => {message: error_message}, :status => :unauthorized
			end
		end
	end
end