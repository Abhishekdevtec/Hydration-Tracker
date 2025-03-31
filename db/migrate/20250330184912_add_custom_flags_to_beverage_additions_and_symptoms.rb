class AddCustomFlagsToBeverageAdditionsAndSymptoms < ActiveRecord::Migration[8.0]
  def change
    add_column :beverage_additions, :is_custom, :boolean, default: false
    add_column :symptoms, :is_custom, :boolean, default: false
  end
end
