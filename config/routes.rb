Rails.application.routes.draw do
  authenticate :employee, ->(employee) { employee.admin? } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  devise_for :employees, sign_out_via: :delete
  root "testers#welcome"
  draw(:testers)
  resources :products
  resources :brands
  resources :departments
  resources :roles
  resources :shops
  draw(:pwa)
end
