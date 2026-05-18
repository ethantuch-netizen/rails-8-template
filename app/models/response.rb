class Response < ApplicationRecord
  belongs_to :question, required: true, class_name: "Question", foreign_key: "question_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
end
