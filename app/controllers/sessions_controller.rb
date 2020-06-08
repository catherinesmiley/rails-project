class SessionsController < ApplicationController

    def new 
        @user = User.new 
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
        @user.username = auth['info']['name']
        @user.password = 'omniauth_password'
        @user.save
        session[:user_id] = @user.id 

        render '/application/home'
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