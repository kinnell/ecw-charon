Charon::Application.routes.draw do

	resources :service_queues, only: [:index, :show, :edit, :create, :update, :destroy] do
    get :manage, on: :member
    get :show_all, on: :collection
  end

	resources :tickets, only: [:create, :edit, :update] do
    get :deactivate, on: :member
  end

	root to: "service_queues#index"
end
