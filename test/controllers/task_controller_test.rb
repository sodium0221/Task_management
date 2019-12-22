require 'test_helper'

class TaskControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get task_top_url
    assert_response :success
  end

end
