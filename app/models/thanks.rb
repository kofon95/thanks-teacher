class Thanks < ApplicationRecord
  scope :published_thanks, -> { where(published: true) }
  # scope :unpublished_thanks, -> { where(published: false) }


  # optimized count of publish and unpubliched
  PUBLICATIONS_COUNT_SQL = <<SQL
select cnt from (
  select 0, count(*) cnt from (#{Thanks.where(published: false).to_sql})
  union
  select 1, count(*) cnt from (#{Thanks.where(published: true).to_sql})
  order by 1
)
SQL
  private_constant :PUBLICATIONS_COUNT_SQL

  def self.union_publications_count
    query_result = ActiveRecord::Base.connection.execute(PUBLICATIONS_COUNT_SQL)

    {
      unpublished: query_result[0][0],
      publiched:   query_result[1][0]
    }
  end
end
