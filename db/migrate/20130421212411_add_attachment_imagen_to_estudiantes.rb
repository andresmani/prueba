class AddAttachmentImagenToEstudiantes < ActiveRecord::Migration
  def self.up
    change_table :estudiantes do |t|
      t.attachment :imagen
    end
  end

  def self.down
    drop_attached_file :estudiantes, :imagen
  end
end
