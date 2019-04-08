class AcademyController < ApplicationController
  def index
    @candidate_form = RegisterRecruiterForm.new
    set_meta_tags title: 'Academy | Global Accounting network Recruitment training academy',
                  description: 'Learn whilst you earn. Everything you need to launch a career in recruitment.',
                  og: { title: 'Academy | Global Accounting network Recruitment training academy' }
  end

  def create
    @candidate_form = RegisterRecruiterForm.new(params['register_recruiter_form'])
    if @candidate_form.valid? && (@candidate_form.verify_1 == '0')
      flash.now[:error] = 'Thanks for your application. Unfortunately you do not meet our requirement for a placement. We require recruiters who are eligible to work in the UK lawfully already.'
      @show_popup = true
    else
      @candidate_form.request = request
      if @candidate_form.deliver
        flash.now[:success] = 'Thank you for your message!'
      else
        flash.now[:error] = @candidate_form.errors.full_messages.to_sentence
      end
    end
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  rescue => e
    flash[:error] = "#{t('forms.send_error')} - #{e.message}"
  end

end
