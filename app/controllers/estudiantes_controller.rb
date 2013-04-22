class EstudiantesController < ApplicationController

  before_filter :find_curso_estudiantes
  helper_method :sort_column, :sort_direction

  def index
    @nrp = (params[:registro] != nil)? params[:registro].to_i : 3

   if ((@nrp) <= 0)
     @nrp = 3
   end
     
      @estudiantes = @curso.estudiante.search(params[:search]).paginate(:per_page=>(@nrp), :page=>params[:page]).order(sort_column + " " + sort_direction)
      respond_to do |format|
      format.html 
      format.xml { render :xml => @estudiantes }
      format.pdf do
         pdf = EstudiantePdf.new(@estudiante, view_context)
        send_data pdf.render, filename:
        "Persona_#{@estudiante.nombre}.pdf",
        type: "application/pdf"
      end 
    end
  end

  def show
       @estudiante = Estudiante.find(params[:id])
  end

  def new
     @estudiante =  Estudiante.new
  end

  def create
     @estudiante = @curso.estudiante.new(params[:estudiante])

   respond_to do |format|
     if @estudiante.save
       format.html { redirect_to curso_estudiantes_path, notice: 'Instructor Ingresado.' }
       format.json { render json: @estudiante, status: :created, location: @estudiante }
     else
       format.html { render action: "new" }
       format.json { render json: @estudiante.errors, status: :unprocessable_entity }
     end
   end
 end

  def update
    @estudiante = Estudiante.find(params[:id])

   respond_to do |format|
     if @estudiante.update_attributes(params[:estudiante])
       format.html { redirect_to curso_estudiantes_path }
       format.json { head :no_content }
     else
       format.html { render action: "edit" }
       format.json { render json: @estudiante.errors, status: :unprocessable_entity }
     end
   end
  end

  def destroy
    @estudiante = Estudiante.find(params[:id])
      @estudiante.destroy
      @estudiantes =Estudiante.all
  end

  private

  def find_curso_estudiantes
     @curso = Curso.find(params[:curso_id])
     @estudiante = Estudiante.find(params[:id]) if params[:id]
  end


def sort_column
  Estudiante.column_names.include?(params[:sort]) ? params[:sort] : "nombre"
end

def sort_direction
  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end
 
end
