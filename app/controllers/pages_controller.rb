class PagesController < ApplicationController
   before_filter :require_login 
   load_and_authorize_resource :only => [:new, :edit, :destroy]	
  def index
  end
end
