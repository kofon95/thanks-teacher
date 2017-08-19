class HomeController < ApplicationController
  def index
    @thanks = Thanks.published_thanks
    @thanks_count = Thanks.published_thanks.count
  end
end
