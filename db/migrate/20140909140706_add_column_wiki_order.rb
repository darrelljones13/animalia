class AddColumnWikiOrder < ActiveRecord::Migration
  def change
  	change_table :orders do |t|
	  t.text :wikitext, :image_name
	end
  end
end
