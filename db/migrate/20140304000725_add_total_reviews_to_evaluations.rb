class AddTotalReviewsToEvaluations < ActiveRecord::Migration
  def change
    add_column :evaluations, :total_reviews, :integer
  end
end
