Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "devise/registrations/registrations"}
  root to: "pages#home"
end
