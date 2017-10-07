Rails.application.routes.draw do
  # api base
  mount Base => '/'
  # do not mount swagger in production
  mount GrapeSwaggerRails::Engine => '/swagger' unless Rails.env.production?
end
