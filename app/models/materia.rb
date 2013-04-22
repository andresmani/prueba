class Materia < ActiveRecord::Base

	validates :nombre, :presence => true,
	  :length => { :minimum =>3, :maximum => 20 }

   has_many :instructor, :dependent => :destroy
   has_many :horarios, :dependent => :destroy
   belongs_to :curso

  attr_accessible :nombre, :curso_id
  	def self.search(search)
	where('nombre like ?', "%#{search}%")
	end
end
