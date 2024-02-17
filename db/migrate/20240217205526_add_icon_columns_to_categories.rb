class AddIconColumnsToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :icon_data, :text
    add_column :categories, :icon_filename, :string
  end
end
