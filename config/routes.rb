Charon::Application.routes.draw do
	resources :service_queues
	resources :tickets

	root to: "service_queues#index"
end
