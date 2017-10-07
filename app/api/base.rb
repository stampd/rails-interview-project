# encoding: utf-8
# frozen_string_literal: false
require 'grape'
require 'grape-entity'
require 'grape-swagger'

class Base < Grape::API
  include Grape::Kaminari

  # common Grape settings
  prefix 'api'
  version 'v1', using: :path
  format :json

  rescue_from :all, backtrace: false do |e|
    Base.send_error_response(e)
  end

  helpers APIHelpers

  before do
    swaggered! || tenant_auth!

    @data = HashConverter.to_param params.except(:limit, :page, :per_page, :offset, :access_token)
    params[:page] = params[:page].to_i if params[:page]
    params[:per_page] = params[:per_page].to_i if params[:per_page]
    params[:offset] = params[:offset].to_i if params[:offset]
  end

  # ---- MOUNT AREA ---- start
  mount API

  # question endpoints
  mount Questions::Record

  # ---- MOUNT AREA ---- end

  add_swagger_documentation api_version: 'v1', hide_documentation_path: true, hide_format: true,
                            info: { title: 'Batteries911 API' }

  def self.send_error_response(e)
    case e
    when ActiveRecord::RecordNotFound
      status = 404
      msg = 'Not Found'
    when ArgumentError
      status = 400
      msg = 'Not Found'
    else
      status = 500
      msg = 'Internal Server Error. Check your parameters.'
    end
    msg << " -- EXCEPTION MSG: #{e.message}"
    Rack::Response.new({ 'status' => status, 'message' => msg }.to_json, status)
  end
end
