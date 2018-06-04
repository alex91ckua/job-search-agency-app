class JoinUsController < ApplicationController
  def index
    @join_form = JoinUsForm.new

    set_meta_tags title: 'Join Our Team | Work For A Financial Recruitment Agency',
                  description: 'Global Accounting Network has grown to become one of the most respected boutique search and recruitment firms in the UK. We are a multi-million turnover business working with exceptional candidates, an array of FTSE clients and some really interesting SMEs. Enquire online today!',
                  og: { title: 'Join Our Team | Work For A Financial Recruitment Agency' }
  end

  def create
    @join_form = JoinUsForm.new(params['join_us_form'])
    @join_form.request = request
    if @join_form.deliver
      flash.now[:success] = 'Thank you for your message!'
    else
      flash.now[:error] = @join_form.errors.full_messages.to_sentence
    end
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  rescue => e
    flash[:error] = "#{t('forms.send_error')} - #{e.message}"
  end
end
