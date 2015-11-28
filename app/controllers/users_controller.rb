#####################################################################
# Copyleft: Free for humanity
# Developer : Ranu Pratap Singh
# Email : singh.ranupratap@gmail.com
# Created Date : 22/07/14
#####################################################################

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @users = @users.accessible_by(current_ability)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize! :read, @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def logged_in
    #This method will return the current logged in user if there is any.
    if current_user
      render json: current_user, :meta => {:initial_permissions => []}
    else
      render json: {:message => 'Nobody logged In'}, status: :ok
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_signin
    user = User.where(:email => params[:username]).first
    if user.nil?
      render json: {:message => 'No such user'}, status: :unauthorized
    elsif user.valid_password? params[:password]
      sign_in(:user, user)
      render json: {:user => user}, status: :ok
    else
      render json: {:message => 'Incorrect Password'}, status: :unauthorized
    end
  end

  def resend_confirmation
    respond_to do |format|
      if current_user and current_user.confirmed_at.nil?
        current_user.send_confirmation_instructions
        format.json { render json: {:message => "Sent"} }
      else
        if !current_user.confirmed_at.nil?
          format.json { render json: {:message => "Already Confirmed"} }
        end
      end
    end
  end

  def forgot_password
    user = User.find_by_email(params[:email])
    respond_to do |format|
      if !user.nil?
        if user.send_reset_password_instructions
          format.json { render json: {:message => "Password reset instructions have been sent to the email."} }
        end
      else
        format.json { render json: {:message => "User does not exist."} }
      end
    end
  end

  def change_password
    if current_user.nil?
      render :json => {:message => 'Error:Not a valid User'}, :status => :precondition_failed
    else
      if current_user.valid_password? params['user']['oldPassword']
        current_user.password=params['user']['newPassword']
        #current_user.reset_password_token=User.reset_password_token
        current_user.reset_password_sent_at = Time.now
        if current_user.save
          #Whenever user changes password we recompute the md5hash so that previous hashes stored on devices don't work.
          #current_user.generate_md5hash
          #Notifier.delay.change_password(current_user)
          render json: {:message => 'Password change successful. Please login again with new password.'}
        else
          render json: {:message => 'There was some error on our side. Please try again later.'}
        end
      else
        render json: {:message => 'It seems you entered the wrong old password'}, :status => :forbidden
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit :first_name, :last_name, :email
  end
end
