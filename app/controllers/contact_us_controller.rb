class ContactUsController < ApplicationController
  def index
    @offices = Office.all

    set_meta_tags title: 'Contact Us | Global Accounting Network',
                  description: 'We help world class financial experts grow their careers by connecting them with challenging and rewarding employment opportunities. We also help companies find world class talent to fill even the most niche positions. Contact us today to find your ideal connection.',
                  og: { title: 'Contact Us | Global Accounting Network' }
  end
end
