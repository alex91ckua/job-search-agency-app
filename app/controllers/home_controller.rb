class HomeController < ApplicationController
  def index
    @callback = CallbackForm.new
  end

  def create_callback
    @callback = CallbackForm.new(params['callback_form'])
    @callback.request = request
    if @callback.deliver
      @callback = CallbackForm.new
      flash.now[:success] = 'Thank you for your message!'
    else
      flash.now[:error] = 'Cannot send message.'
    end
  end

end
