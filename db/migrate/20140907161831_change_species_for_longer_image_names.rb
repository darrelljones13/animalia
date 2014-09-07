class ChangeSpeciesForLongerImageNames < ActiveRecord::Migration
  def change
  	change_table :species do |t|
	  t.remove :wikitext, :image_name
	  t.text :wikitext, :image_name
	end
  end
end
