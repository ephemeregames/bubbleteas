source 'https://rubygems.org'

gem 'rails', '3.2.8'                                                  # Rails
#gem 'inherited_resources'                                             # DRY controllers
gem 'jquery-rails'                                                    # JQuery
gem 'thin'                                                            # Web server (instead of Webrick)
gem 'backbone-rails'                                                  # Backbone for responsive client-side
gem 'pg'                                                              # Database for Heroku


group :development do
  gem 'sqlite3'                                                       # Database
end

# Cannot be part of :assets group because needed in production
gem 'coffee-rails'                                                    # Coffeescript to generate Javascript
gem 'uglifier'                                                        # Minify CSS and Javascript
gem 'coffee-filter'                                                   # Embed coffeescript in haml

group :assets do
  gem 'i18n-js'                                                       # Provide internationalization on the client side
  gem 'haml'                                                          # Haml to generate HTML
  gem 'sass-rails'                                                    # SASS to generate CSS
  gem 'anjlab-bootstrap-rails', '>= 2.1', require: 'bootstrap-rails'  # Frontend UI
  gem 'haml_coffee_assets'                                            # Create JS templates in HAML with inline CoffeeScript
  gem 'execjs'                                                        # Dependency for HAML Coffee Assets
end
