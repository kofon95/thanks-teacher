class Thanks < ApplicationRecord
  scope :published_thanks, -> { where(published: true) }
  after_initialize :set_full_image_path
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

  def self.union_publications_count
    query_result = ActiveRecord::Base.connection.execute(PUBLICATIONS_COUNT_SQL)

    {
      unpublished: query_result[0]['cnt'],
      published:   query_result[1]['cnt']
    }
  end

  IMAGES_DIR = 'uploads'
  IMAGES_PATH = "#{S3_BUCKET.url}/#{IMAGES_DIR}/"
  private
    def set_full_image_path
      images.each { |img| img[0,0] = IMAGES_PATH }
    end
end
