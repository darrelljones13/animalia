class AddColumnPhotoGenus < ActiveRecord::Migration
  def change
  	change_table :genus do |t|
	  t.text :wikitext, :image_name
	end
  end
end
