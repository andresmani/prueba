class HorariosController < ApplicationController

  before_filter :require_login
  load_and_authorize_resource :only => [:new, :edit, :destroy]
  helper_method :sort_column, :sort_direction
  
  def index
    @nrp = (params[:registro] != nil)? params[:registro].to_i : 3

   if ((@nrp) <= 0)
     @nrp = 3
   end
    @horarios = Horario.search(params[:search]).paginate(:per_page=>(@nrp), :page=>params[:page]).order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html
      format.xml { render :xml => @horarios }
    end
  end


  def show
      @horario = Horario.find(params[:id])   

     if params[:format] == "pdf"
          pdf = HorarioPdf.new(@horario, view_context)
          send_data pdf.render, filename:
          "horario_#{@horario.id}.pdf", 
          type: "application/pdf"
      end
  end

  def new
      @horario= Horario.new
  end

  def edit
      @horario = Horario.find(params[:id])
  end

  def create
      @horario= Horario.new(params[:horario])
      render :action => :new unless @horario.save
      @horarios =Horario.all
  end

   def update
      @horario = Horario.find(params[:id])
      render :action => :edit unless @horario.update_attributes(params[:horario])
  end

  def destroy
      @horario = Horario.find(params[:id])
      @horario.destroy
      @horarios = Horario.all
  end
  
  private
  def sort_column
    Horario.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
