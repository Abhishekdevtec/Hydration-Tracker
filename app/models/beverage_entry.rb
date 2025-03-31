class BeverageEntry < ApplicationRecord
  belongs_to :user
  belongs_to :beverage_type, optional: true
  belongs_to :beverage_subtype, optional: true
  
  has_many :beverage_entry_additions, dependent: :destroy
  has_many :beverage_additions, through: :beverage_entry_additions
  
  has_many :beverage_entry_symptoms, dependent: :destroy
  has_many :symptoms, through: :beverage_entry_symptoms

  has_one_attached :photo
end
