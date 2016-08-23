class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name
      t.integer :story_id
      t.datetime :story_date

      t.timestamps
    end
  end
end
