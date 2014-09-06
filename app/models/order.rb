class Order < ActiveRecord::Base
  belongs_to :chlass
  has_many :families
  has_many :genus, through: :family

  validates :name, uniqueness: true

  def taxonomy
    {
    "kingdom" => self.chlass.phylum.kingdom.name,
    "phylum" => self.chlass.phylum.name.split("-")[0].split(" ")[0],
    "class" => self.chlass.name.split("-")[0].split(" ")[0]
    }
  end
end
