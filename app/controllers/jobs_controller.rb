class JobsController < ApplicationController
  before_action :set_job, only: :show
  before_action :set_meta

  # GET /jobs
  # GET /jobs.json
  def index
    @candidate_form = RegisterCandidateForm.new
    @jobs = Job.order(created_at: :desc)

    is_contract_type = false
    is_contract_type = true if params[:job_type] && Integer(params[:job_type]) == Job.job_types[:contract]
    rate = params[:salary_range]
    rate = params[:rate_range] if is_contract_type
    filter_by_rate(rate, is_contract_type)
    filter_jobs
  end

  private

  def filter_by_rate(rate, is_contract_type)
    if rate && rate.match(/^\d*-\d*$/)
      rates = rate.split('-')
      @jobs = @jobs.salary_from_to(rates[0], rates[1]) unless is_contract_type
      @jobs = @jobs.day_rate_from_to(rates[0], rates[1]) if is_contract_type
    end
  end

  def filter_jobs
    @jobs = @jobs.location(params[:location]) if params[:location].present?
    @jobs = @jobs.job_type(params[:job_type]) if params[:job_type].present?
    @jobs = @jobs.job_function(params[:job_function]) if params[:job_function].present?
    @jobs = @jobs.sector(params[:sector]) if params[:sector].present?
    @jobs = @jobs.ordered_by_date if params[:order_by] == 'date'
    @jobs = @jobs.ordered_by_title if params[:order_by] == 'title'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  def set_meta
    set_meta_tags title: 'Full List of Job Openings | Find Employment In The Finance Sector',
                  description: 'Use our search tool to find your ideal job. We connect top talent in finance to great companies all across the UK. Our connections run deep across a wide range of industries and specialisations. Find your perfect match in just a few minutes online!',
                  og: {
                    title: 'Full List of Job Openings | Find Employment In The Finance Sector'
                  }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def job_params
  #   params.require(:job).permit(:title, :job_type, :sector, :salary, :description, :company_description, :responsibilities, :location)
  # end
end
