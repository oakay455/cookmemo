class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :member, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
