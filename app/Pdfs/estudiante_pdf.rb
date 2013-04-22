class Estudiantepdf < Prawn::Document
	def initialize(estudiante, viw)
		super()
		@estudiante = estudiante
		@viw = viw
		logo
		deliver_details
		persona_details
	end

	def logo
		logopath = "#{Rails.root}/app/assets/images/default.jpg"
    image logopath, :width => 150, :height => 70
    move_down 10 draw_text "estudiante Details", :at => [220, 675], size: 22
			
	end	
end