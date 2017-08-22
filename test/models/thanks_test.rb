require 'test_helper'

class ThanksTest < ActiveSupport::TestCase
  test "respond_to attributes" do
    model = Thanks.new
    assert_respond_to model, :visitor_name
    assert_respond_to model, :teacher_name
    assert_respond_to model, :school_name
    assert_respond_to model, :body
    assert_respond_to model, :published
  end

  test 'create new "thanks"' do
    count = Thanks.count
    Thanks.create!(
                    visitor_name: 'foo',
                    teacher_name: 'bar',
                    school_name: 'baz',
                    body: 'bat',
                    published: true
    )
    assert_same count+1, Thanks.count
  end

  test 'default value for column "published"' do
    count = Thanks.count
    t = Thanks.create!(
                    visitor_name: 'foo',
                    teacher_name: 'bar',
                    school_name: 'baz',
                    body: 'bat'
    )
    assert_same count+1, Thanks.count
    assert_not t.published
  end

  test 'union_publications_count' do
    actual = {
      published: Thanks.where(published: true).count,
      unpublished: Thanks.where(published: false).count
    }
    assert_equal actual, Thanks.union_publications_count
  end
end
