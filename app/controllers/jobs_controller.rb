class JobsController < ApplicationController
  before_action :set_job, only: [:show]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    @jobs = @jobs.salary_from(params[:salary_from]) if params[:salary_from].present?
    @jobs = @jobs.salary_to(params[:salary_to]) if params[:salary_to].present?
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
