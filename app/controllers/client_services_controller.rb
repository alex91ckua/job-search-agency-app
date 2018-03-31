class ClientServicesController < ApplicationController
  def index
    @vacancy_form = RegisterVacancyForm.new

    set_meta_tags title: 'Clients - Partnering With You to Provide a Solution',
                  description: 'We take pride in our clients relationships.
                  We listen to you and understand your requirements,
                  creating a bespoke plan suited to your hiring needs.',
                  og: { title: 'Clients - Partnering With You to Provide a Solution' }
  end
end
