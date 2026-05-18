class Question < ApplicationRecord
  has_many  :responses, class_name: "Response", foreign_key: "question_id", dependent: :destroy
end
