class CandidateFormMailer < ApplicationMailer
  def candidate_apply_mail
    @candidate = params[:candidate]
    @candidate_admin_url = params[:url]
    unless @candidate.attachment.file.nil?
      attachments[@candidate.attachment.file.filename.to_s] = @candidate.attachment.read
    end
    mail(to: Setting.email,
         subject: "New candidate application for job #{@candidate.job.title}")
  end
end
