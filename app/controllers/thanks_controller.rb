class ThanksController < ApplicationController
  before_action :should_be_admin, except: [:create, :index]

  def index
    show = params[:show]
    if show
      unless signed_in?
        render json: {message: "You're not an admin"}, status: :unauthorized and return
      end

      if show == 'all'
        thanks = Thanks.all
      else
        thanks = Thanks.where(published: show != 'unpublished')
      end
    else
      thanks = Thanks.published_thanks
    end

    q = params[:q]
    offset = fetch_offset
    count = fetch_count
    if q.present?
      q = "%#{q.downcase}%"
      thanks = thanks.where("lower(visitor_name) like :q or lower(teacher_name) like :q or
                             lower(school_name) like :q or lower(body) like :q", {q: q})
    end

    thanks = thanks.order('created_at desc').offset(offset).limit(count).to_a

    respond_to do |format|
      format.json {render json: thanks}

      # home search ajax
      format.js do
        @thanks = thanks
        @thanks_count = Thanks.published_thanks
        render 'home/index'
      end
      format.html do
        @thanks = thanks
        @thanks_count = Thanks.published_thanks
        render 'home/index'
      end
    end
  end

  def create
    Thanks.create! thanks_params
    render plain: thanks_params, status: :created
  end

  def edit
    respond_to do |format|
      format.html do
        @publications_count = Thanks.union_publications_count
      end
      format.json {render json: {message: 'not implemented'}}
    end
  end

  def update
    prm = params.require(:thanks)
                .permit :visitor_name, :teacher_name,
                        :school_name, :body, :published
    # byebug
    Thanks.find(params[:id]).update_attributes! prm
    render plain: '' + Thanks.find(params[:id]).inspect
  end

  def destroy
    Thanks.find(params[:id]).destroy
  end

  private
    def thanks_params
      params.require(:thanks).permit :visitor_name, :teacher_name, :school_name, :body, images: []
    end
    def should_be_admin
      redirect_to signin_path unless signed_in?
    end
    def fetch_offset
      params[:offset] || 0
    end
    def fetch_count
      params[:count] || 5
    end
end
