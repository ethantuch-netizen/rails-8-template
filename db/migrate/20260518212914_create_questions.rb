class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.text :content
      t.string :audio_content_and_answer
      t.string :content_answer
      t.string :gmat_section

      t.timestamps
    end
  end
end
