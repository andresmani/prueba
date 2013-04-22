class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :nombre
      t.string :ficha
      

      t.timestamps
    end
   
  end
end
