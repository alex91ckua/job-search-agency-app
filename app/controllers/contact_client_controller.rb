class ContactClientController < ApplicationController

  before_action :prepare_vacancy_form, only: :create

  def index
    @vacancy_form = RegisterVacancyForm.new

    set_meta_tags title: 'Register a Vacancy - We Can Help You',
                  description: 'Register a vacancy, and we will make contact
                  to discuss and understand your talent requirements
                  in greater detail.',
                  og: { title: 'Register a Vacancy - We Can Help You' }
  end

  def create
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

  private

  def prepare_vacancy_form
    @vacancy_form = RegisterVacancyForm.new(params['register_vacancy_form'])
    @vacancy_form.request = request
  end

end
