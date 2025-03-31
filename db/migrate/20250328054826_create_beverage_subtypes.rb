class CreateBeverageSubtypes < ActiveRecord::Migration[8.0]
  def change
    create_table :beverage_subtypes do |t|
      t.string :name
      t.references :beverage_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
