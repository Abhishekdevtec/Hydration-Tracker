class BeverageAddition < ApplicationRecord
  STANDARD_ADDITIONS = [
    "Sugar", "Milk", "Creamer", "Lemon", "Lime", "Honey",
    "Artificial Sweeteners", "Protein Powder", "Electrolyte Powder"
  ].freeze

  has_many :beverage_entry_additions, dependent: :destroy
  has_many :beverage_entries, through: :beverage_entry_additions

  scope :standard, -> { where(name: STANDARD_ADDITIONS) }
  scope :custom, -> { where.not(name: STANDARD_ADDITIONS) }

  before_create :set_custom_flag

  private

  def set_custom_flag
    self.is_custom = !STANDARD_ADDITIONS.include?(name)
  end
end
