class InstructoresController < ApplicationController
  
     before_filter :require_login
     load_and_authorize_resource :only => [:new, :edit, :destroy]
     before_filter :find_materia_instructores 
     helper_method :sort_column, :sort_direction
     
   def index
    @nrp = (params[:registro] != nil)? params[:registro].to_i : 3

    if ((@nrp) <= 0)
     @nrp = 3
   end
    @instructores = Instructor.search(params[:search]).paginate(:per_page=>(@nrp), :page=>params[:page]).order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html
      format.xml { render :xml => @instructores }
    end
  end

  def new
      @instructor= Instructor.new
  end

  def create
   @instructor = @materia.instructor.new(params[:instructor])
   render :action => :new unless @instructor.save
   @instructores = Instructor.all
 end

   def update
     @instructor = Instructor.find(params[:id])
     render :action => :edit unless @instructor.update_attributes(params[:instructor])
  end

  def destroy
      @instructor = Instructor.find(params[:id])
      @instructor.destroy
      @instructores = Instructor.all
  end

  private

  def find_materia_instructores
    @materia = Materia.find(params[:materia_id])
    @instructor = Instructor.find(params[:id]) if params[:id]
      
  end  

  def sort_column
    Instructor.column_names.include?(params[:sort]) ? params[:sort] : "nombre"
  end
   
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end

