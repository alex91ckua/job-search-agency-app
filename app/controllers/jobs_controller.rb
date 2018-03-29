class JobsController < ApplicationController
  before_action :set_job, only: [:show]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    if params[:salary_range]
      salary = params[:salary_range].split('-')
      @jobs = @jobs.salary_from(salary[0]) if salary[0].present?
      @jobs = @jobs.salary_to(salary[1]) if salary[1].present?
    end

    @jobs = @jobs.location(params[:location]) if params[:location].present?
    @jobs = @jobs.job_type(params[:job_type]) if params[:job_type].present?
    @jobs = @jobs.title(params[:title]) if params[:title].present?
    @jobs = @jobs.sector(params[:sector]) if params[:sector].present?
    @jobs = @jobs.ordered_by_date if params[:order_by] == 'date'
    @jobs = @jobs.ordered_by_title if params[:order_by] == 'title'
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def job_params
    #   params.require(:job).permit(:title, :job_type, :sector, :salary, :description, :company_description, :responsibilities, :location)
    # end
end
