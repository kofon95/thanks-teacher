class HomeController < ApplicationController
  def index
    @thanks = Thanks.published_thanks
  end
end
