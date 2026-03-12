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

  authenticated :user do
    root to: redirect("/index"), as: :index
  end

  devise_scope :user do
    root to: redirect('/default')
  end

  get "default", to: redirect('/default.html')
  get "index", to: redirect('/default.html')
  get "ecmsCharge", to: redirect('/ecmsCharge.html')
  get "queryMenu", to: redirect('/queryMenu.html')
  get "queryEcmsRecharge", to: redirect('/queryEcmsRecharge.html')
  get "queryEcmsRecharge3", to: redirect('/queryEcmsRecharge3.html')
  get "manage/home.jsp", to: 'application#normalized', defaults: { file: "home.html" }

  get '/manage/*path', to: 'application#normalized'
  get '/taglib/*path', to: 'application#normalized'

  post "login.action;jsessionid=:jsessionid", to: "application#login"
  post "iface/findEcmsAddressTreeNode2", to: "application#findEcmsAddressTreeNode2"
  post "iface/findKeyIndicators", to: "application#findKeyIndicators"
  post "iface/findDailyElectricity", to: "application#findDailyElectricity"
  post "iface/findMonthElectricity", to: "application#findMonthElectricity"
  post "iface/searchEcmsShortCut", to: "application#searchEcmsShortCut"
  post "iface/findEcmsWarnInfo", to: "application#findEcmsWarnInfo"
  post "iface/searchEcmsPayCustomer3", to: "application#searchEcmsPayCustomer3"
  post "iface/searchEcmsRecharge", to: "application#searchEcmsRecharge"
  post "iface/findCustomerTreeNode", to: "application#findCustomerTreeNode"
  post "iface/findEcmsAddressTreeNode", to: "application#findEcmsAddressTreeNode"
end
