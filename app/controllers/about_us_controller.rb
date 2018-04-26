class AboutUsController < ApplicationController
  def index
    @staff = Staff.all.order(position: :asc)

    set_meta_tags title: 'About Us',
                  description: 'Our Finance and Accounting practice means we
                  recruit from mid-range to senior positions
                  into industry and commerce,
                  both on a permanent and interim basis.',
                  og: { title: 'About Us' }
  end
end
