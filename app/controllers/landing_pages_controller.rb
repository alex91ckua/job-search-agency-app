class LandingPagesController < InheritedResources::Base
  def show
    @lp = LandingPage.friendly.find(params[:id])
    set_meta_tags title: @lp.title,
                  description: @lp.subtitle,
                  og: { title: @lp.title }

    @candidate_form = RegisterLandingCandidateForm.new
  end

  def create
    @candidate_form = RegisterLandingCandidateForm.new(params['register_landing_candidate_form'])
    if @candidate_form.valid? && (@candidate_form.verify_1 == '0' ||  @candidate_form.verify_2 == '0')
      flash.now[:error] = 'Thanks for your application. Unfortunately you do not meet our requirement for a placement. We require candidates to be fully qualified accountants who are eligible to work in the UK lawfully already.'
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
