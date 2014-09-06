class Family < ActiveRecord::Base
  belongs_to :your_mom, class_name: "Order", foreign_key: 'order_id'
  has_many :genus
  has_many :species, through: :genus


  validates :name, uniqueness: true

  def belongs_to

  end

end
