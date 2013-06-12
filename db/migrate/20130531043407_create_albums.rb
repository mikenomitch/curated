class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :band
      t.string :image_url
      t.string :input_url
      t.string :embed_url
      t.integer :rating
      t.text :review
      t.references :user

      t.timestamps
    end
  end
end
