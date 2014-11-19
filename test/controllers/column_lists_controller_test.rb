require 'test_helper'

class ColumnListsControllerTest < ActionController::TestCase
  setup do
    @column_list = column_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:column_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create column_list" do
    assert_difference('ColumnList.count') do
      post :create, column_list: {  }
    end

    assert_redirected_to column_list_path(assigns(:column_list))
  end

  test "should show column_list" do
    get :show, id: @column_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @column_list
    assert_response :success
  end

  test "should update column_list" do
    patch :update, id: @column_list, column_list: {  }
    assert_redirected_to column_list_path(assigns(:column_list))
  end

  test "should destroy column_list" do
    assert_difference('ColumnList.count', -1) do
      delete :destroy, id: @column_list
    end

    assert_redirected_to column_lists_path
  end
end
