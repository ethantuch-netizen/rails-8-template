class ResponsesController < ApplicationController
  def build_study_set
    selected_question_ids = []

    params.each do |a_key, a_value|
      if a_key.start_with?("use_question_") && a_value == "yes"
        question_id = a_key.delete_prefix("use_question_").to_i
        selected_question_ids.push(question_id)
      end
    end

    session.store("selected_question_ids", selected_question_ids)

    chosen_destination = params.fetch("destination")

    if chosen_destination == "quiz"
      redirect_to("/start_quiz?current_index=0")
    else
      redirect_to("/start_audio")
    end
  end

  def audio
    selected_question_ids = session.fetch("selected_question_ids", [])

    @selected_questions = Question.where({ :id => selected_question_ids }).order({ :id => :asc })
    
    render({ :template => "response_templates/audio" })
  end

  def flashcards
    quiz_question_ids = session.fetch("selected_question_ids", [])
    current_index = params.fetch("current_index", "0").to_i

    current_question_id = quiz_question_ids.at(current_index)

    if current_question_id.nil?
      @quiz_summary_rows = []

      quiz_question_ids.each do |a_question_id|
        matching_questions = Question.where({ :id => a_question_id })
        the_question = matching_questions.at(0)

        matching_responses = Response.where({
          :user_id => current_user.id,
          :question_id => a_question_id,
        }).order({ :id => :desc })

        the_response = matching_responses.at(0)

        row_data = {
          "question" => the_question,
          "response" => the_response,
        }

        @quiz_summary_rows.push(row_data)
      end

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

end
