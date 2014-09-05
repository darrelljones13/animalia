class CreateChlasses < ActiveRecord::Migration
  def change
    create_table :chlasses do |t|
      t.integer   :phylum_id
      t.string   :name, unique: true

      t.timestamps
    end
  end
end
