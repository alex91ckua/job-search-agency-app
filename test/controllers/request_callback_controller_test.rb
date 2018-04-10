require 'test_helper'

class RequestCallbackControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get request_callback_url
    assert_response :success
  end

  test 'should create request callback' do
    post request_callback_url, params:
        {
          callback_form:
          {
            first_name: 'text',
            last_name: 'text',
            request_type: 'General',
            phone: '123',
            company_name: 'text',
            call_time: 'text',
            email: 'jonh@mail.com',
            nickname: ''
          }
        }

    assert_response :success
  end

  test 'should not create request callback' do
    post request_callback_url, params:
        {
          callback_form:
              {
                first_name: 'text',
                last_name: 'text'
              }
        }

    assert_response 400
  end
end
