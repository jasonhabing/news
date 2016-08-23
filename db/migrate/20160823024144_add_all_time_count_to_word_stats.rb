class AddAllTimeCountToWordStats < ActiveRecord::Migration
  def change
    add_column :word_stats, :all_time_count, :integer
  end
end
