class RequestCallbackController < ApplicationController
  def index
    @callback = CallbackForm.new
  end

  def create
    @callback = CallbackForm.new(params['callback_form'])
    @callback.request = request
    if @callback.deliver
      @callback = CallbackForm.new
      flash.now[:success] = 'Thank you for your message!'
      status_code = 200
    else
      flash.now[:error] = @callback.errors.full_messages.to_sentence
      status_code = 400
    end
    respond_to do |format|
      format.html { render :index, status: status_code }
      format.js
    end
  end
end
