class Thanks < ApplicationRecord
  scope :published_thanks, -> { where(published: true) }
  before_save :set_empty_images_by_default
  # scope :unpublished_thanks, -> { where(published: false) }


  # optimized count of publish and unpubliched
  PUBLICATIONS_COUNT_SQL = <<SQL
select cnt from (
  #{Thanks.where(published: false).select('0, count(*) cnt').to_sql}
  union
  #{Thanks.where(published: true).select('1, count(*) cnt').to_sql}
  order by 1
) _t
SQL
  private_constant :PUBLICATIONS_COUNT_SQL
  IMAGES_PATH = "#{S3_BUCKET.url}/#{ENV['UPLOAD_DIR']}/"

  def self.union_publications_count
    query_result = ActiveRecord::Base.connection.execute(PUBLICATIONS_COUNT_SQL)

    {
      unpublished: query_result[0]['cnt'],
      published:   query_result[1]['cnt']
    }
  end

  attribute :image_urls
  def image_urls
    @image_urls ||= images.map { |img| IMAGES_PATH + img }
  end

  def set_empty_images_by_default
    self.images = [] if self.images.nil?
  end
end
