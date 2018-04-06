require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = jobs(:one)
  end

  test "should get index" do
    get jobs_url
    assert_response :success
  end

  test "should get index without salary range param" do
    get jobs_url, params: {:salary_range => 'text'}
    assert_response :success
  end

  test "should get index with salary range param" do
    get jobs_url, params: {:salary_range => '100-500'}
    assert_response :success
  end

  test "should show job" do
    get job_url(@job)
    assert_response :success
  end
end
