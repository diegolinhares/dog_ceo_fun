Rails.application.routes.draw do
  get "main/index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :main, only: [ :index ]

  root "main#index"
end
