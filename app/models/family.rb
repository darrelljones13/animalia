class Family < ActiveRecord::Base
  belongs_to :order
  has_many :genus
  has_many :species, through: :genus

  validates :name, uniqueness: true

  def taxonomy
    {
    "kingdom" => self.order.chlass.phylum.kingdom.name,
    "phylum" => self.order.chlass.phylum.name.split("-")[0].split(" ")[0],
    "class" => self.order.chlass.name.split("-")[0].split(" ")[0],
    "order" => self.order.name.split("-")[0].split(" ")[0]
    }
  end


end
