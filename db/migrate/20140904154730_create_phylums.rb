class CreatePhylums < ActiveRecord::Migration
  def change
    create_table :phylums do |t|
      t.integer   :kingdom_id
      t.string   :name, unique: true

      t.timestamps
    end
  end
end
