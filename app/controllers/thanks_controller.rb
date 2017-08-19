class ThanksController < ApplicationController
  before_action :should_be_admin, expect: :create

  def create
    Thanks.create! thanks_params
    render plain: '', status: :created
  end

  def index
    offset = params[:offset] || 0
    count = params[:count] || 20
    thanks = Thanks.offset(offset).limit(count)
    respond_to do |format|
      format.json {render json: thanks}
    end
  end

  def edit
    respond_to do |format|
      format.html do
        # @thanks = Thanks.all
        @thanks_count = Thanks.all.count
      end
      format.json {render json: {message: 'not implemented'}}
    end
  end

  def destroy
    Thanks.find(params[:id]).destroy
  end

  private
    def thanks_params
      params.require(:thanks).permit :visitor_name, :teacher_name, :school_name, :body
    end
    def should_be_admin
      redirect_to signin_path if current_admin.nil?
    end
end
