class AboutUsController < ApplicationController
  def index
    @staff = Staff.all
  end
end
