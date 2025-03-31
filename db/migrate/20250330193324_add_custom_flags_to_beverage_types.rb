class AddCustomFlagsToBeverageTypes < ActiveRecord::Migration[8.0]
  def change
    add_column :beverage_types, :is_custom, :boolean, default: false
  end
end
