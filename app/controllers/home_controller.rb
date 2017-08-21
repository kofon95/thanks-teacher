class HomeController < ApplicationController
  COUNT_THANKS = 10
  
  def index
    @thanks = Thanks.published_thanks.order('created_at desc').limit(COUNT_THANKS).to_a
    @thanks_count = Thanks.published_thanks.count
  end
end
