#####################################################################
# Copyleft: Free for humanity
# Developer : Ranu Pratap Singh
# Email : singh.ranupratap@gmail.com
# Created Date : 22/07/14
#####################################################################

module Users
	class SessionsController < Devise::SessionsController
		respond_to :json,:html
	end
end