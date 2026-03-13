Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  get "manage/home.jsp", to: 'application#normalized', defaults: { file: "home.html" }
  get '/manage/*path', to: 'application#normalized'
  get '/taglib/*path', to: 'application#normalized'

  authenticated :user do
    get "logout", to: "application#logout"
    get "index", to: 'application#normalized', defaults: { file: "index.html" }, format: false

    get "ecmsCharge", to: 'application#normalized', defaults: { file: "ecmsCharge.html" }
    get "queryMenu", to: 'application#normalized', defaults: { file: "queryMenu.html" }
    get "queryEcmsRecharge", to: 'application#normalized', defaults: { file: "queryEcmsRecharge.html" }
    get "queryEcmsRecharge3", to: 'application#normalized', defaults: { file: "queryEcmsRecharge3.html" }
    get "changePersonalPassword", to: 'application#normalized', defaults: { file: "changePersonalPassword.html" }
    post "iface/*path", to: "application#do"
    get "*path", to: redirect('/index')
  end

  devise_scope :user do
    post "login.action;jsessionid=:jsessionid", to: "application#login"
    get "default", to: 'application#normalized', defaults: { file: "default.html" }, format: false
    get "*path", to: redirect('/default')
  end
end
