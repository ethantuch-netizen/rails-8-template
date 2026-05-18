# == Schema Information
#
# Table name: questions
#
#  id                       :bigint           not null, primary key
#  audio_content_and_answer :string
#  content                  :text
#  content_answer           :string
#  gmat_section             :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class Question < ApplicationRecord
  has_many  :responses, class_name: "Response", foreign_key: "question_id", dependent: :destroy
end
