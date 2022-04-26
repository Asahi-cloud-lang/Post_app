class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title, presence: true, length: { maximum: 10 }
      t.text :content, presence: true
      t.text :image
      t.boolean :image_presence     
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
