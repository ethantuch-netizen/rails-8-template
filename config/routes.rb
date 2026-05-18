Rails.application.routes.draw do
  # Routes for the Question resource:

  # CREATE
  post("/insert_question", { :controller => "questions", :action => "create" })

  # READ
  get("/questions", { :controller => "questions", :action => "index" })

  get("/questions/:path_id", { :controller => "questions", :action => "show" })

  # UPDATE

  post("/modify_question/:path_id", { :controller => "questions", :action => "update" })

  # DELETE
  get("/delete_question/:path_id", { :controller => "questions", :action => "destroy" })

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })
end
