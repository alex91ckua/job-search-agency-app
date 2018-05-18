class CandidatesController < ApplicationController
  def create
    @candidate = Candidate.create(candidate_params)
    if @candidate.errors.any?
      flash.now[:error] = @candidate.errors.full_messages.to_sentence
    else
      begin
      flash.now[:success] = t('candidate_form.thanks_for_apply')
      CandidateFormMailer.with(candidate: @candidate, url: admin_candidate_url(@candidate)).candidate_apply_mail.deliver_now
      rescue => e
        flash[:error] = "#{t('forms.send_error')} - #{e.message}"
      end
    end
  end

  private
  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :email, :phone, :attachment, :job_alerts, :job_id)
  end
end
