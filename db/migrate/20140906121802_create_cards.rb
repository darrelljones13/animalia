class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :user_id, :collection_id, :species_id
      
      t.timestamps
    end
  end
end
