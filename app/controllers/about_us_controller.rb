class AboutUsController < ApplicationController
  def index
    @staff = Staff.all.order(position: :asc)

    set_meta_tags title: 'About Us | Who Are GAN?',
                  description: 'We help qualified finance accounting professionals develop their careers by matching them with rewarding and well-targeted employment opportunities. We proactively help companies find world class talent to fill even the most specialised positions. Contact us today to find your ideal connection.',
                  og: { title: 'About Us | Who Are GAN?' }
  end
end
