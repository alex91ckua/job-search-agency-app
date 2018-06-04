class ClientServicesController < ApplicationController
  def index
    @vacancy_form = RegisterVacancyForm.new

    set_meta_tags title: 'Find World Class Talent Online | Recruit Talent In The Finance Sector',
                  description: 'Use our search tool to find your perfect candidate. We leverage the power of our network to connect you with job seekers that match your criteria. Our online search tool makes the process easy. Find your pefect match in just a few minutes online!',
                  og: {
                    title: 'Find World Class Talent Online | Recruit Talent In The Finance Sector'
                  }
  end
end
