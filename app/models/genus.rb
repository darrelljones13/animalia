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

end
