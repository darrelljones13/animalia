class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.integer   :order_id
      t.string   :name, unique: true

      t.timestamps
    end
  end
end
