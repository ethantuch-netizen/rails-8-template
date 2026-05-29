class QuestionsController < ApplicationController
  def home
    render({ :template => "question_templates/home" })
  end
  
  def index
    matching_questions = Question.all

    @list_of_questions = matching_questions.order({ :id => :asc })

    render({ :template => "question_templates/index" })
  end

end
