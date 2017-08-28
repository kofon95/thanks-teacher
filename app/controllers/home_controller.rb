class HomeController < ApplicationController
  before_action :set_s3_direct_post
  COUNT_THANKS = 10
  
  def index
    @thanks = Thanks.published_thanks.order('created_at desc').limit(COUNT_THANKS).to_a
    @thanks_count = Thanks.published_thanks.count
  end

  def set_s3_direct_post
    @s3_dir_name = SecureRandom.uuid
    @s3_direct_post = S3_BUCKET.presigned_post(
      key: "#{Thanks.IMAGES_DIR}/#{@s3_dir_name}/${filename}",
      success_action_status: '201', acl: 'public-read'
    )
  end
end
