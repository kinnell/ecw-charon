Charon::Application.routes.draw do
	resources :service_queues, only: [:index, :show, :create, :update, :destroy] do
    get :manage, on: :member
  end
	resources :tickets, only: [:create, :update, :destroy]

	root to: "service_queues#index"
end
