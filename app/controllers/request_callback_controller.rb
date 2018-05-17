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
        status_code = 200
      else
        flash.now[:error] = @callback.errors.full_messages.to_sentence
        status_code = 400
      end
    rescue => ex
      flash.now[:error] = "Sorry, something bad occur. Error: #{ex.message}"
      # logger.error ex.message
    end
    respond_to do |format|
      format.html { render :index, status: status_code }
      format.js
    end
  rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
    flash[:error] = t('forms.send_error')
  end
end
