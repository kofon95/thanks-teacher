class HomeController < ApplicationController
  before_action :set_s3_direct_post
  COUNT_THANKS = 10
  
  def index
    @thanks = Thanks.published_thanks.order('created_at desc').limit(COUNT_THANKS).to_a
    @thanks_count = Thanks.published_thanks.count
  end

  def set_s3_direct_post
    HomeController.set_s3_direct_post(self)
  end
  def self.set_s3_direct_post(controller)
    s3_dir_name = SecureRandom.uuid
    s3_direct_post = S3_BUCKET.presigned_post(
      key: "#{ENV['UPLOAD_DIR']}/#{s3_dir_name}/${filename}",
      success_action_status: '201', acl: 'public-read'
    )
    controller.instance_variable_set(:@s3_dir_name, s3_dir_name)
    controller.instance_variable_set(:@s3_direct_post, s3_direct_post)
  end
end
