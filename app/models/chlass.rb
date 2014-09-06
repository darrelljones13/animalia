class Chlass < ActiveRecord::Base
  belongs_to :phylum
  has_many :orders
  has_many :families, through: :order

  validates :name, uniqueness: true

  def taxonomy
    {
    "kingdom" => self.phylum.kingdom.name,
    "phylum" => self.phylum.name.split("-")[0].split(" ")[0]
    }
  end
end
