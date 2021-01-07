require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transactions_index_url
    assert_response :success
  end

  test "should get deposit" do
    get transactions_deposit_url
    assert_response :success
  end

  test "should get withdraw" do
    get transactions_withdraw_url
    assert_response :success
  end

  test "should get transfer" do
    get transactions_transfer_url
    assert_response :success
  end

  test "should get amount" do
    get transactions_amount_url
    assert_response :success
  end

  test "should get report_extract" do
    get transactions_report_extract_url
    assert_response :success
  end

end
