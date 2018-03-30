class ContactClientController < ApplicationController
  def index
    @vacancy_form = RegisterVacancyForm.new
  end

  def create
    @vacancy_form = RegisterVacancyForm.new(params['register_vacancy_form'])
    @vacancy_form.request = request
    if @vacancy_form.deliver
      flash.now[:success] = 'Thank you for your message!'
    else
      flash.now[:error] = @vacancy_form.errors.full_messages.to_sentence
    end
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end
end
