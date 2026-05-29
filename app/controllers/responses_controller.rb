class ResponsesController < ApplicationController
  
  def flashcards
    #matching_questions = Question.where({ :id => 1 })
    #@the_question = matching_questions.at(0)
    #render({ :template => "response_templates/flashcards" })

    quiz_question_ids = [1, 2, 3, 4]
    current_index = params.fetch("current_index", "0").to_i

    current_question_id = quiz_question_ids.at(current_index)

    if current_question_id.nil?
      render({ :template => "response_templates/finished" })
    else
      matching_questions = Question.where({ :id => current_question_id })
      @the_question = matching_questions.at(0)
      @current_index = current_index

      render({ :template => "response_templates/flashcards" })
    end
  end

  def mark_correct
    the_response = Response.new
    the_response.user_id = current_user.id
    the_response.question_id = params.fetch("question_id")
    the_response.correct_result = true
    the_response.save

    next_index = params.fetch("current_index").to_i + 1

    redirect_to("/start_quiz?current_index=#{next_index}")
  end

  def mark_incorrect
    the_response = Response.new
    the_response.user_id = current_user.id
    the_response.question_id = params.fetch("question_id")
    the_response.correct_result = false
    the_response.save

    next_index = params.fetch("current_index").to_i + 1

    redirect_to("/start_quiz?current_index=#{next_index}")
  end
  
  def index
    matching_responses = Response.all

    @list_of_responses = matching_responses.order({ :created_at => :desc })

    render({ :template => "response_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_responses = Response.where({ :id => the_id })

    @the_response = matching_responses.at(0)

    render({ :template => "response_templates/show" })
  end

  def create
    the_response = Response.new
    the_response.user_id = params.fetch("query_user_id")
    the_response.question_id = params.fetch("query_question_id")
    the_response.correct_result = params.fetch("query_correct_result")

    if the_response.valid?
      the_response.save
      redirect_to("/responses", { :notice => "Response created successfully." })
    else
      redirect_to("/responses", { :alert => the_response.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_response = Response.where({ :id => the_id }).at(0)

    the_response.user_id = params.fetch("query_user_id")
    the_response.question_id = params.fetch("query_question_id")
    the_response.correct_result = params.fetch("query_correct_result")

    if the_response.valid?
      the_response.save
      redirect_to("/responses/#{the_response.id}", { :notice => "Response updated successfully." } )
    else
      redirect_to("/responses/#{the_response.id}", { :alert => the_response.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_response = Response.where({ :id => the_id }).at(0)

    the_response.destroy

    redirect_to("/responses", { :notice => "Response deleted successfully." } )
  end
end
