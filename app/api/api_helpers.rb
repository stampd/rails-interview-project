# encoding: utf-8
# frozen_string_literal: true
# helpers for v1 Grape API
module APIHelpers
  def success!(message = '')
    { status: 200, metadata: message }
  end

  def success_empty!(message = '')
    { status: 201, metadata: message }
  end

  def access_denied!(message = '')
    error!({ status: 401, message: "Access Denied. #{message} " }, 401)
  end

  def bad_request!(message = '')
    error!({ status: 400, message: "Bad Request. #{message} " }, 400)
  end

  def forbidden_request!(message = '')
    error!({ status: 403, message: "Forbidden. #{message} " }, 403)
  end

  def not_found!(message = '')
    error!({ status: 404, message: "Not Found. #{message} " }, 404)
  end

  def invalid_request!(message)
    error!({ status: 422, message: "Invalid Request. #{message} " }, 422)
  end

  def conflict!(message)
    error!({ status: 409, message: "Conflict. #{message} " }, 409)
  end

  def invalid_login_attempt(message = '')
    access_denied!(message)
  end

  def logger
    API.logger
  end

  def warden
    env['warden']
  end

  def swaggered!
    headers['Authorization'] == Rails.application.secrets.swagger_auth
  end

  def tenant
    Tenant.find_by_api_key(headers['Authorization'])
  end

  def tenant_auth!
    tenant.present?
  end

  def current_tenant
    @current_tenant ||= tenant if tenant_auth!
    @current_tenant ||= Tenant.first if swaggered!
    @current_tenant
  end

end
