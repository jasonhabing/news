class CreateNewspapers < ActiveRecord::Migration
  def change
    create_table :newspapers do |t|
      t.string :name
      t.string :website
      t.string :main_rss_feed_url
      t.integer :circulation
      t.string :owner

      t.timestamps
    end
  end
end
