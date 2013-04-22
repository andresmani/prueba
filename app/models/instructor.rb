class Instructor < ActiveRecord::Base
  attr_accessible :cedula, :direccion, :email, :apellido, :nombre, :telefono, :materia_id, :imagen
  has_many :horarios, :dependent => :destroy
  belongs_to :materia

validates :nombre, :presence=>true,
	:length => { :minimum =>3, :maximum => 80 }

  validates :apellido, :presence=>true,
  :length => { :minimum =>3, :maximum => 80 }

	validates :cedula, :presence => true,
  :length => { :minimum => 10, :maximum => 11 },
  :numericality => true

	validates :email, :presence => true,
  :uniqueness => true,
  :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :direccion, :presence=>true

  validates :telefono, :presence=>true,
  :length => { :minimum => 7, :maximum => 20 },
  :numericality => true


  def self.search(search)
  	where('nombre like ? or apellido like ? or cedula like ?  or direccion like ? or telefono like ?', "%#{search}%" , "%#{search}%" , "%#{search}%" , "%#{search}%" , "%#{search}%" )
  end

  has_attached_file :imagen, :styles => { :small => "150x150>",:lsmall => "30x30>" },
                  :url  => "/assets/instructores/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/instructores/:id/:style/:basename.:extension"

validates_attachment_presence :imagen
validates_attachment_size :imagen, :less_than => 5.megabytes
validates_attachment_content_type :imagen, :content_type => ['image/jpeg', 'image/png']

end

