class CandidatesController < ApplicationController
  def create
    @candidate = Candidate.create(candidate_params)
  end

  private
  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :email, :phone, :attachment, :job_alerts, :job_id)
  end
end
