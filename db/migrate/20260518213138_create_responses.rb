class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :question_id
      t.boolean :correct_result

      t.timestamps
    end
  end
end
