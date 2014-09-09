class ChangeColumnWikiInfo < ActiveRecord::Migration
  def change
  	change_column(:species, :wikitext, :text)
  	change_column(:species, :image_name, :text)
  end
end
