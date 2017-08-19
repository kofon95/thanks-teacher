class ThanksController < ApplicationController
  def create
    Thanks.create! params_thank
    render plain: '', status: :created
  end

  private
    def params_thank
      params.require(:thank).permit :visitor_name, :teacher_name, :school_name, :body
    end
end
