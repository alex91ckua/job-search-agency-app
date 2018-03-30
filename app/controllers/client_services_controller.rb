class ClientServicesController < ApplicationController
  def index
    @vacancy_form = RegisterVacancyForm.new
  end
end
