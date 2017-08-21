require 'test_helper'

class ThanksControllerTest < ActionDispatch::IntegrationTest
  test "should create new thanks" do
    thanks_params = {
      visitor_name: 'Foo (Thanks.post)',
      teacher_name: 'Bar (Thanks.post)',
      school_name: 'Baz (Thanks.post)',
      body: 'Bat (Thanks.post)',
    }
    Thanks.where(thanks_params).destroy_all

    post thanks_url, params: {thanks: thanks_params}

    assert response.created?
    assert_same 1, Thanks.where(thanks_params.merge(published: false)).count
  end

  test 'count of #index.json' do
    get thanks_path format: :json, count: 1
    result = JSON.parse(response.body)
    assert_same 1, result.size
  end

  test 'max offset of #index.json' do
    get thanks_path format: :json, count: 1, offset: Thanks.published_thanks.count
    result = JSON.parse(response.body)
    assert result.empty?
  end

  test 'offset of #index.json' do
    get thanks_path format: :json, count: 1, offset: Thanks.published_thanks.count-1
    result = JSON.parse(response.body)
    assert 1, result.size
  end
end
