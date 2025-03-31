class CreateBeverageAdditions < ActiveRecord::Migration[8.0]
  def change
    create_table :beverage_additions do |t|
      t.string :name

      t.timestamps
    end
  end
end
