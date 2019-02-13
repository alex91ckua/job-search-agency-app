class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :redirect_to_us

  private

  def redirect_to_us
    # redirect_to US_MIRROR_URL if request.location.country_code == 'US'
  end
end
