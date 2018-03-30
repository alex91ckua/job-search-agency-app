class ContactCandidateController < ApplicationController
  def index
    @candidate_form = RegisterCandidateForm.new
  end

  def create
    @candidate_form = RegisterCandidateForm.new(params['register_candidate_form'])
    @candidate_form.request = request
    if @candidate_form.deliver
      flash.now[:success] = 'Thank you for your message!'
    else
      flash.now[:error] = @candidate_form.errors.full_messages.to_sentence
    end
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end
end
