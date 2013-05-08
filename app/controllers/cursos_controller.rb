class CursosController < ApplicationController
  
    before_filter :require_login
   load_and_authorize_resource :only => [:new, :edit, :destroy]
    before_filter :find_curso, :except => [ :index, :create, :new ]
    helper_method :sort_column, :sort_direction

def index
    @nrp = (params[:registro] != nil)? params[:registro].to_i : 3

    if ((@nrp) <= 0)
     @nrp = 3
   end
    @cursos = Curso.search(params[:search]).paginate(:per_page=>(@nrp), :page=>params[:page]).order(sort_column + " " + sort_direction)

      respond_to do |format|
      format.html 
      format.xml { render :xml => @cursos }
    end
  end

  def new
      @curso = Curso.new
  end

  def create
      @curso = Curso.new(params[:curso])
      render :action => :new unless @curso.save
      @cursos = Curso.all
  end

  def update
      render :action => :edit unless @curso.update_attributes(params[:curso])
  end

  def destroy
      @curso = Curso.find(params[:id])
      @curso.destroy
      @cursos =Curso.all
  end

  private

  def find_curso
      @curso = Curso.find(params[:id]) if params[:id]
  end
 

def sort_column
    Curso.column_names.include?(params[:sort]) ? params[:sort] : "nombre"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  
end