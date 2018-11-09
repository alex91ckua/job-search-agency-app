class LandingPagesController < InheritedResources::Base
  def show
    @callback = CallbackForm.new
    @lp = LandingPage.friendly.find(params[:id])
    set_meta_tags title: @lp.title,
                  description: @lp.subtitle,
                  og: { title: @lp.title }

    @candidate_form = RegisterCandidateForm.new
  end
end
