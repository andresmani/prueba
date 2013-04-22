class Horario < ActiveRecord::Base
    validates :aula, :presence => true
    validates :dia, :presence => true
    validates :instructor, :presence => true 
    validates :curso, :presence => true
    validates :materia, :presence => true


  belongs_to :materia
  belongs_to :curso
  belongs_to :instructor
  attr_accessible :dia, :aula, :hora, :materia_id, :instructor_id, :curso_id

  def self.search(search)
	where('aula like ?',"%#{search}%")
	end
end
