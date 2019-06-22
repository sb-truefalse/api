Rails.application.routes.draw do
	namespace :api do
    namespace :v1 do
	    scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
		    resources :films, only: [:index, :show, :create, :update, :destroy]
	    end
		end
	end
end
