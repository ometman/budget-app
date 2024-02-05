class CreateDeals < ActiveRecord::Migration[7.1]
  def change
    create_table :deals do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :name
      t.decimal :amount
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
