class CreateRecipeFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_favorites do |t|
      t.integer :member_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
