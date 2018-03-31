class JoinUsController < ApplicationController
  def index
    @join_form = JoinUsForm.new
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
  end
end
