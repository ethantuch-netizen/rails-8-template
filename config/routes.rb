Rails.application.routes.draw do
  devise_for :users

  get("/", { :controller => "questions", :action => "home" })

  get("/questions", { :controller => "questions", :action => "index" })

  get("/start_quiz", { :controller => "responses", :action => "flashcards" })
  post("/build_study_set", { :controller => "responses", :action => "build_study_set" })
  post("/mark_correct", { :controller => "responses", :action => "mark_correct" })
  post("/mark_incorrect", { :controller => "responses", :action => "mark_incorrect" })

  get("/start_audio", { :controller => "responses", :action => "audio" })

  require "digest"

  Rails.application.routes.draw do
    if Rails.env.production?
      rails_db_username = ENV.fetch("RAILS_DB_USERNAME")
      rails_db_password = ENV.fetch("RAILS_DB_PASSWORD")

      protected_rails_db = Rack::Auth::Basic.new(RailsDb::Engine) do |username, password|
        username_matches = ActiveSupport::SecurityUtils.secure_compare(
          Digest::SHA256.hexdigest(username.to_s),
          Digest::SHA256.hexdigest(rails_db_username)
        )

        password_matches = ActiveSupport::SecurityUtils.secure_compare(
          Digest::SHA256.hexdigest(password.to_s),
          Digest::SHA256.hexdigest(rails_db_password)
        )

        username_matches & password_matches
      end

      mount(protected_rails_db => "/rails/db")
    else
      mount(RailsDb::Engine => "/rails/db")
    end

    # your other routes go here
  end
end
