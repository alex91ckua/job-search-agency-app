class JoinUsController < ApplicationController
  def index
    @join_form = JoinUsForm.new

    set_meta_tags title: 'Work For Us - join our exciting and ambitious team!',
                  description: 'We&#039;re all about people.
                                We want positive and ambitious sales people who
                                gets excited about new challenges.
                                Take a look and see if you should work for us!',
                  og: { title: 'Work For Us - join our exciting and ambitious team!' }
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
