class ContactUsController < ApplicationController
  def index
    @offices = Office.all

    set_meta_tags title: 'Contact Us - The Best Way To Say Hello',
                  description: 'Whether you\'re actively pursuing
                  your next role, looking for a great candidate, or just
                  want to talk about the job market,
                  contact us on +44 (0)203 617 9197',
                  og: { title: 'Contact Us - The Best Way To Say Hello' }
  end
end
