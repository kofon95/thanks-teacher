require 'test_helper'

class ThanksControllerTest < ActionDispatch::IntegrationTest
  test "should create new thanks" do
    thank_params = {
      visitor_name: 'Foo (Thanks.post)',
      teacher_name: 'Bar (Thanks.post)',
      school_name: 'Baz (Thanks.post)',
      body: 'Bat (Thanks.post)',
    }
    Thanks.where(thank_params).destroy_all

    post thanks_url, params: {thank: thank_params}

    assert response.created?
    assert_same 1, Thanks.where(thank_params.merge(published: false)).count
  end
end
