class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :member_id, null: false
      t.integer :category_id, null: false
      t.string :title, null: false
      t.string :ingredient, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
