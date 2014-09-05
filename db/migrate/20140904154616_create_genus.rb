class CreateGenus < ActiveRecord::Migration
  def change
    create_table :genus do |t|
      t.integer   :family_id
      t.string   :name, unique: true

      t.timestamps
    end
  end
end
