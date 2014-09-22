Charon::Application.routes.draw do
	resources :service_queues, only: [:index, :create, :update, :destroy]
	resources :tickets, only: [:create, :update, :destroy]

	root to: "service_queues#index"
end
