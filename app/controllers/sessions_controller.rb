class SessionsController < ApplicationController
    def new
        render :new
    end
    def create
        @user = User.find_by_credentials(user_params[:email],user_params[:password])
        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ["Invalid Email or Password"]
            render :new
        end
    end
    def destroy
        @user = current_user
        logout!
        redirect_to users_url
    end
end