class AddSpeciesWikiInfo < ActiveRecord::Migration
  def change
  	change_table :species do |t|
	  t.string :wikitext, :image_name
	end
  end
end
