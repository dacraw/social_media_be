class CreateUserRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :user_ratings do |t|
      t.belongs_to :user
      t.belongs_to :rater, foreign_key: { to_table: 'users' }
      t.integer :rating
      t.datetime :rated_at

      t.timestamps
    end
  end
end