require 'test_helper'

class ThanksTest < ActiveSupport::TestCase
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
end
