class AddParsedDateToStories < ActiveRecord::Migration
  def change
  	add_column :stories, :parsed_date, :datetime
  end
end
