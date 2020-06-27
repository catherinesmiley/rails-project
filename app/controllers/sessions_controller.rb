class SessionsController < ApplicationController

    require 'securerandom'

    def new 
        if !current_user
            @user = User.new 
        else 
            flash[:notice] = "You're already logged in!"
            redirect_to root_path
        end 
    end 

    def create 
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else 
            render :new
        end 
    end 

    def fb_create
        @user = User.find_or_create_by(username: auth['info']['email'])
        if !@user.password 
            @user.password = SecureRandom.hex(10)
        end 

        @user.save
        session[:user_id] = @user.id 

        redirect_to user_path(@user)
    end 

    def destroy 
        session.delete :user_id
        redirect_to root_path
    end
    
    private 

    def auth 
        request.env['omniauth.auth']
    end 

end