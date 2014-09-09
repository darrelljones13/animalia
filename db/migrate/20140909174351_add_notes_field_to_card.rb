class AddNotesFieldToCard < ActiveRecord::Migration
  def change

  	change_table :cards do |t|
	  	t.text :note 
		end

  end
end
