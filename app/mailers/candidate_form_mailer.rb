class CandidateFormMailer < ApplicationMailer
  def candidate_apply_mail
    @candidate = params[:candidate]
    @url = params[:url]
    mail(to: Setting.email,
         subject: "New candidate application for job #{@candidate.job.title}")
  end
end
