class CandidatesController < ApplicationController
  def create
    @candidate = Candidate.create(candidate_params)
    if @candidate.errors.any?
      flash.now[:error] = @candidate.errors.full_messages.to_sentence
    else
      flash.now[:success] = 'Thanks for your application'
    end
  end

  private
  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :email, :phone, :attachment, :job_alerts, :job_id)
  end
end
