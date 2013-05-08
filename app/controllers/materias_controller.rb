class MateriasController < ApplicationController

   before_filter :require_login
   load_and_authorize_resource :only => [:new, :edit, :destroy]
   helper_method :sort_column, :sort_direction
   
  def index
    @nrp = (params[:registro] != nil)? params[:registro].to_i : 3

   if ((@nrp) <= 0)
     @nrp = 3
   end
    @materias = Materia.search(params[:search]).paginate(:per_page=>(@nrp), :page=>params[:page]).order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html
      format.xml { render :xml => @materias }
    end
  end

  def show
      @materia = Materia.find(params[:id])
  end

  def new
      @materia= Materia.new
  end

  def edit
      @materia = Materia.find(params[:id])
  end

  def create
      @materia = Materia.new(params[:materia])
      render :action => :new unless @materia.save
      @materias = Materia.all
  end

   def update
      @materia = Materia.find(params[:id])
      render :action => :edit unless @materia.update_attributes(params[:materia])
  end

  def destroy
      @materia = Materia.find(params[:id])
      @materia.destroy
      @materias = Materia.all
  end
  private
  def sort_column
    Materia.column_names.include?(params[:sort]) ? params[:sort] : "nombre"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end

