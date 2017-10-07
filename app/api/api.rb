# encoding: utf-8
# frozen_string_literal: true
class API < Grape::API
  namespace :info do
    desc 'Provides information about the API'
    get do
      { api: 'Batteries911', version: version }
    end
  end
end
