class BeverageType < ApplicationRecord
  STANDARD_CATEGORIES = [
    "Water-Based Beverages",
    "Coffee-Based Beverages", 
    "Tea-Based Beverages",
    "Juice & Smoothies",
    "Dairy-Based Beverages",
    "Plant-Based Milks",
    "Fermented & Probiotic Beverages",
    "Carbonated & Artificially Sweetened Drinks",
    "Alcoholic Beverages"
  ].freeze

  has_many :beverage_subtypes, dependent: :destroy
  has_many :beverage_entries, dependent: :nullify

  scope :standard, -> { where(name: STANDARD_CATEGORIES) }
  scope :custom, -> { where.not(name: STANDARD_CATEGORIES) }

  before_create :set_custom_flag

  private

  def set_custom_flag
    self.is_custom = !STANDARD_CATEGORIES.include?(name)
  end
end
