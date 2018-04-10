class JobsController < ApplicationController
  before_action :set_job, only: :show
  before_action :set_meta

  # GET /jobs
  # GET /jobs.json
  def index
    @candidate_form = RegisterCandidateForm.new
    @jobs = Job.all
    filter_by_salary
    filter_jobs
  end

  private

  def filter_by_salary
    if params[:salary_range] && params[:salary_range].match(/^\d*-\d*$/)
      salary = params[:salary_range].split('-')
      @jobs = @jobs.salary_from_to(salary[0], salary[1])
    end
  end

  def filter_jobs
    @jobs = @jobs.location(params[:location]) if params[:location].present?
    @jobs = @jobs.job_type(params[:job_type]) if params[:job_type].present?
    @jobs = @jobs.title(params[:title]) if params[:title].present?
    @jobs = @jobs.sector(params[:sector]) if params[:sector].present?
    @jobs = @jobs.ordered_by_date if params[:order_by] == 'date'
    @jobs = @jobs.ordered_by_title if params[:order_by] == 'title'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  def set_meta
    set_meta_tags title: 'Current Jobs',
                  description: 'Top candidates. Great companies.',
                  og: {
                    title: 'Current Jobs'
                  }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def job_params
  #   params.require(:job).permit(:title, :job_type, :sector, :salary, :description, :company_description, :responsibilities, :location)
  # end
end
