class Card < ActiveRecord::Base
  belongs_to :collection
  belongs_to :user
  belongs_to :species
end
