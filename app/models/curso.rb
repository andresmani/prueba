class Curso < ActiveRecord::Base
	validates :nombre, :presence => true,
	  :length => {:minimum =>3, :maximum => 80 }

	validates :ficha, :presence => true,
	:length => { :minimum => 4, :maximum => 10 },
	:numericality => true

 
  has_many :horarios, :dependent => :destroy
  has_many :estudiante, :dependent => :destroy
  attr_accessible :ficha, :nombre 

  def self.search(search)
	where('nombre like ? or ficha like ?', "%#{search}%","%#{search}%")
	end
	
end
