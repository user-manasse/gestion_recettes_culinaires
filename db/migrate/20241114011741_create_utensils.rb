class CreateUtensils < ActiveRecord::Migration[7.0]
  def change
    create_table :utensils do |t|
      t.string :name
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
