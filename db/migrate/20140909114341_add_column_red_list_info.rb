class AddColumnRedListInfo < ActiveRecord::Migration
  def change
  	change_table :species do |t|
  	  t.integer :red_list_id
	  t.text :range, :habitat, :major_threats
	end
  end
end
