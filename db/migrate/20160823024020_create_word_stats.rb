class CreateWordStats < ActiveRecord::Migration
  def change
    create_table :word_stats do |t|
      t.string :name
      t.float :one_month_frequency
      t.float :one_week_frequency
      t.float :one_day_frequency
      t.float :half_day_frequency
      t.float :quarter_day_frequency
      t.float :one_hour_frequency

      t.timestamps
    end
  end
end
