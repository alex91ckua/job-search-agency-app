class HomeController < ApplicationController
  def index
    @callback = CallbackForm.new
  end
end
