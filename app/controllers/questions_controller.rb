class QuestionsController < ApplicationController
  def index
    matching_questions = Question.all

    @list_of_questions = matching_questions.order({ :created_at => :desc })

    render({ :template => "question_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_questions = Question.where({ :id => the_id })

    @the_question = matching_questions.at(0)

    render({ :template => "question_templates/show" })
  end

  def create
    the_question = Question.new
    the_question.content = params.fetch("query_content")
    the_question.audio_content_and_answer = params.fetch("query_audio_content_and_answer")
    the_question.content_answer = params.fetch("query_content_answer")
    the_question.gmat_section = params.fetch("query_gmat_section")

    if the_question.valid?
      the_question.save
      redirect_to("/questions", { :notice => "Question created successfully." })
    else
      redirect_to("/questions", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_question = Question.where({ :id => the_id }).at(0)

    the_question.content = params.fetch("query_content")
    the_question.audio_content_and_answer = params.fetch("query_audio_content_and_answer")
    the_question.content_answer = params.fetch("query_content_answer")
    the_question.gmat_section = params.fetch("query_gmat_section")

    if the_question.valid?
      the_question.save
      redirect_to("/questions/#{the_question.id}", { :notice => "Question updated successfully." } )
    else
      redirect_to("/questions/#{the_question.id}", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_question = Question.where({ :id => the_id }).at(0)

    the_question.destroy

    redirect_to("/questions", { :notice => "Question deleted successfully." } )
  end
end
