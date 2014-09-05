class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer   :chlass_id
      t.string   :name, unique: true

      t.timestamps
    end
  end
end
