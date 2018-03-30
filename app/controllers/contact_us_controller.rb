class ContactUsController < ApplicationController
  def index
    @offices = Office.all
  end
end
