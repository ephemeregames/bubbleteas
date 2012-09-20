InterfaceTest::Application.routes.draw do

  resources :users
  resource :session

  namespace 'api' do
    resources :bubble_teas do
      collection do
        get :chef_choices
        get :top
      end
    end

    resources :ingredients
    resources :ingredient_categories
  end

  root to: 'index#index'

end
