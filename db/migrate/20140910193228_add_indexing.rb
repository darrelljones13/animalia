class AddIndexing < ActiveRecord::Migration
  def change
    add_index :species, :genus_id
    add_index :species, :scientific_name
    add_index :species, :common_name
    add_index :genus, :family_id
    add_index :families, :order_id
    add_index :orders, :chlass_id
  end
end
