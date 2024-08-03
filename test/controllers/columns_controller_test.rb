# frozen_string_literal: true

require 'test_helper'

class ColumnsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get columns_show_url
    assert_response :success
  end

  test 'should get create' do
    get columns_create_url
    assert_response :success
  end
end
