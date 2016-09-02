class AddAlgorithmReviewToMatchs < ActiveRecord::Migration
  def change
    add_column :matches, :algorithm_review, :integer
  end
end
