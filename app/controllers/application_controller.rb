class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :geo_variables

  def geo_variables
    @client_ip = request.remote_ip
  end
end
