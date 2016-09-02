class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :story_one_id
      t.integer :story_two_id
      t.integer :human_review

      t.timestamps
    end
  end
end
