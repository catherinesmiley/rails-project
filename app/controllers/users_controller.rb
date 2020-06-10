class UsersController < ApplicationController

    before_action :logged_in?, except: [:new, :create]

    def new 
        if !current_user
            @user = User.new
        else 
            redirect_to root_path
        end 
    end 

    def create 
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else 
            render :new
        end 
    end 

    def show 
        @user = User.find_by(id: params[:id])
        if !@user || @user.id != session[:user_id]
            redirect_to root_path
        end 
    end 

    def index 
        @users = User.all
    end 

    private 

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end 

end
