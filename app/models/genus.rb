class Genus < ActiveRecord::Base
  belongs_to :family
  has_many :species

  validates :name, uniqueness: true

  def taxonomy
    {
    "kingdom" => self.family.order.chlass.phylum.kingdom.name,
    "phylum" => self.family.order.chlass.phylum.name,
    "class" => self.family.order.chlass.name,
    "order" => self.family.order.name,
    "family" => self.family.name
    }
  end

  def parent_name
    "family"
  end

  def self
    "genus"
  end

  def get_genus_photos
    @photo = "/image/tree-frog-logo.png"
    @species = Species.where(genus_id: self.id)
    @species.each do |species|
      if species.image_name != nil
        @photo = species.image_name
        return {image_name: @photo }
      end
    end
    {image_name: @photo }
  end

  

end
