class AddAttachmentImagenToInstructores < ActiveRecord::Migration
  def self.up
    change_table :instructores do |t|
      t.attachment :imagen
    end
  end

  def self.down
    drop_attached_file :instructores, :imagen
  end
end
