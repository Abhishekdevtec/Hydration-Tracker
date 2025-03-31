class BeverageEntrySymptom < ApplicationRecord
  belongs_to :beverage_entry
  belongs_to :symptom
end
