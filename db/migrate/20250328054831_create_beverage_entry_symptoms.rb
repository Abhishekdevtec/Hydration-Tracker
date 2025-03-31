class CreateBeverageEntrySymptoms < ActiveRecord::Migration[8.0]
  def change
    create_table :beverage_entry_symptoms do |t|
      t.references :beverage_entry, null: false, foreign_key: true
      t.references :symptom, null: false, foreign_key: true
      t.string :severity
      t.string :timing
      t.text :notes

      t.timestamps
    end
  end
end
