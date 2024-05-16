Rails.application.routes.draw do
  get "main/index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :main, only: [ :index ]

  namespace :dog_ceo_api do
    resources :searches, only: [ :create ]
  end

  root "main#index"
end
