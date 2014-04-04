ResumeKaizen::Application.routes.draw do

  devise_for :users

  resources :resumes

  root to: 'welcome#index'
  match "about" => 'welcome#about', via: :get
  match "reviewers" => 'welcome#reviewers', via: :get

end
