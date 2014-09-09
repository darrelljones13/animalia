class AddColumnWikiFamily < ActiveRecord::Migration
  def change
  	change_table :families do |t|
	  t.text :wikitext, :image_name
	end
  end
end
