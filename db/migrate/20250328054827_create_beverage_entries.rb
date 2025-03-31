class CreateBeverageEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :beverage_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :beverage_type, null: false, foreign_key: true
      t.references :beverage_subtype, null: false, foreign_key: true
      t.datetime :consumed_at
      t.decimal :quantity
      t.string :unit
      t.string :temperature
      t.string :custom_type
      t.text :notes

      t.timestamps
    end
  end
end
