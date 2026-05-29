Rails.application.routes.draw do
  devise_for :users

  get("/", { :controller => "questions", :action => "home" })

  get("/questions", { :controller => "questions", :action => "index" })

  get("/start_quiz", { :controller => "responses", :action => "flashcards" })
  post("/build_study_set", { :controller => "responses", :action => "build_study_set" })
  post("/mark_correct", { :controller => "responses", :action => "mark_correct" })
  post("/mark_incorrect", { :controller => "responses", :action => "mark_incorrect" })

  get("/start_audio", { :controller => "responses", :action => "audio" })

end
