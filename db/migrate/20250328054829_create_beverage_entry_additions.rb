class CreateBeverageEntryAdditions < ActiveRecord::Migration[8.0]
  def change
    create_table :beverage_entry_additions do |t|
      t.references :beverage_entry, null: false, foreign_key: true
      t.references :beverage_addition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
