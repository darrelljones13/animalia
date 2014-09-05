class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.integer   :genus_id
      t.string   :common_name
      t.string   :scientific_name, unique: true
      t.string   :red_list_status

      t.timestamps
    end
  end
end
