class HomeController < ApplicationController
  def index
    @callback = CallbackForm.new

    set_meta_tags title: 'Global Accounting Network | UK Finance Talent Recruitment Professionals',
                  description: 'We provide career and talent solutions in finance all across the UK. We serve both job seekers and companies seeking world class financial specialists. Our team has deep connections across a range of sectors. We use our network to connect talent to even the hardest to fill spots.',
                  og: { title: 'Global Accounting Network | UK Finance Talent Recruitment Professionals' }
  end
end
