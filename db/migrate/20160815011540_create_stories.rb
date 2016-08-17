class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.datetime :published
      t.text :summary
      t.integer :newspaper_id

      t.timestamps
    end
  end
end
