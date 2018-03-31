class HomeController < ApplicationController
  def index
    @callback = CallbackForm.new

    set_meta_tags title: 'Finance Jobs in London',
                  description: 'We work with exceptional companies on the best
                               finance jobs in London and across the globe.
                               We\'re a boutique finance
                               recruitment agency who\'d love to help.',
                  og: { title: 'Finance Jobs in London' }
  end
end
