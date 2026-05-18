# == Schema Information
#
# Table name: responses
#
#  id             :bigint           not null, primary key
#  correct_result :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  question_id    :integer
#  user_id        :integer
#
class Response < ApplicationRecord
  belongs_to :question, required: true, class_name: "Question", foreign_key: "question_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
end
