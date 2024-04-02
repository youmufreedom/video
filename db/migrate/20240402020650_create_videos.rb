class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :organisation, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :file
      t.string :thumbnail
      t.string :overlay

      t.timestamps
    end
  end
end
