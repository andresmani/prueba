class SessionsController < ApplicationController

 #load_and_authorize_resource :only => [:show, :new, :edit, :destroy]

  def create
    user = login(params[:username], params[:password], params[:remember_me])
  if user
    redirect_back_or_to root_path
  else
    flash.now.alert = "Email o clave invlidos"
    render :new
  end
  end

  def destroy
    logout
  redirect_to login_path
  end
end