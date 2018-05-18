# Contact candidate form controller
class ContactCandidateController < ApplicationController

  before_action :prepare_candidate_form, only: :create

  def index
    @candidate_form = RegisterCandidateForm.new

    set_meta_tags title: 'Register Interest - Gain Access To Our Network',
                  description: 'When you register interest with us,
                  our first step is to meet with you to understand
                  your needs and long-term goals, and your capabilities.',
                  og: {
                    title: 'Register Interest - Gain Access To Our Network'
                  }
  end

  def create
    if @candidate_form.deliver
      flash.now[:success] = 'Thank you for your message!'
    else
      flash.now[:error] = @candidate_form.errors.full_messages.to_sentence
    end
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  rescue => e
    flash[:error] = "#{t('forms.send_error')} - #{e.message}"
  end

  private

  def prepare_candidate_form
    @candidate_form = RegisterCandidateForm.new(params['register_candidate_form'])
    @candidate_form.request = request
  end

end
