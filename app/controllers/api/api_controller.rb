# frozen_string_literal: true

module Api
  # api_controller
  class ApiController < ActionController::Base
    protect_from_forgery with: :null_session
  end
end
