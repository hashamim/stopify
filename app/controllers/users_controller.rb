class UsersController < ApplicationController
    def new
        render :new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        # debugger
        @user = User.find_by(id: params[:id])
        if @user && @user == current_user
            render :show
        else
            redirect_to users_url
        end

    end

    def edit
    end

    def index
        render :index
    end
end