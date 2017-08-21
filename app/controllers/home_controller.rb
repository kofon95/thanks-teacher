class HomeController < ApplicationController
  def index
    @thanks = Thanks.published_thanks.order('created_at desc').limit(5).to_a
    @thanks_count = Thanks.published_thanks.count
  end
end
