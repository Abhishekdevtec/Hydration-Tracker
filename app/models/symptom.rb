class Symptom < ApplicationRecord
  STANDARD_SYMPTOMS = [
    "Bloating", "Discomfort", "Nausea", "Acid Reflux / Heartburn",
    "Burping / Excess Gas", "Diarrhea / Loose Stools", "Constipation",
    "Cramping / Abdominal Pain", "Urgency to Poop", "Mucus in Stool",
    "Fatty / Oily Stools (Steatorrhea)", "Undigested Food in Stool",
    "Feeling Full / Heavy Stomach", "Dizziness / Lightheadedness",
    "Headache", "Dry Mouth / Sticky Saliva"
  ].freeze

  has_many :beverage_entry_symptoms, dependent: :destroy
  has_many :beverage_entries, through: :beverage_entry_symptoms

  scope :standard, -> { where(name: STANDARD_SYMPTOMS) }
  scope :custom, -> { where.not(name: STANDARD_SYMPTOMS) }

  before_create :set_custom_flag

  private

  def set_custom_flag
    self.is_custom = !STANDARD_SYMPTOMS.include?(name)
  end
end
