class Genus < ActiveRecord::Base
  belongs_to :family
  has_many :species

  validates :name, uniqueness: true

  def taxonomy
    {
    "kingdom" => self.family.order.chlass.phylum.kingdom.name,
    "phylum" => self.family.order.chlass.phylum.name.split("-")[0].split(" ")[0],
    "class" => self.family.order.chlass.name.split("-")[0].split(" ")[0],
    "order" => self.family.order.name.split("-")[0].split(" ")[0],
    "family" => self.family.name.split("-")[0].split(" ")[0]
    }
  end

end
