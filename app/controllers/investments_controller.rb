class InvestmentsController < ApplicationController
  def new
    @investment = Investment.new
    respond_to do |format|
      format.html
      format.js
    end
  end
end
