class RequestCallbackController < ApplicationController
  def index
    @callback = CallbackForm.new
  end

  def create
    @callback = CallbackForm.new(params['callback_form'])
    @callback.request = request
    begin
      if @callback.deliver
        @callback = CallbackForm.new
        flash.now[:success] = 'Thank you for your message!'
      else
        flash.now[:error] = @callback.errors.full_messages.to_sentence
      end
    rescue => ex
      flash.now[:error] = "Sorry, something bad occur. Error: #{ex.message}"
      # logger.error ex.message
    end
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  rescue => e
    flash[:error] = "#{t('forms.send_error')} - #{e.message}"
  end

  def thanks_for_apply
    set_meta_tags title: 'Thanks for your apply! | UK Finance Talent Recruitment Professionals',
                description: 'We provide career and talent solutions in finance all across the UK. We serve both job seekers and companies seeking world class financial specialists. Our team has deep connections across a range of sectors. We use our network to connect talent to even the hardest to fill spots.',
                og: { title: 'Thanks for for job apply! | UK Finance Talent Recruitment Professionals' }
  end
end
