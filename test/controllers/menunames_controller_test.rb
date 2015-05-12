require 'test_helper'

class MenunamesControllerTest < ActionController::TestCase
  setup do
    @menuname = menunames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:menunames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create menuname" do
    assert_difference('Menuname.count') do
      post :create, menuname: {  }
    end

    assert_redirected_to menuname_path(assigns(:menuname))
  end

  test "should show menuname" do
    get :show, id: @menuname
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @menuname
    assert_response :success
  end

  test "should update menuname" do
    patch :update, id: @menuname, menuname: {  }
    assert_redirected_to menuname_path(assigns(:menuname))
  end

  test "should destroy menuname" do
    assert_difference('Menuname.count', -1) do
      delete :destroy, id: @menuname
    end

    assert_redirected_to menunames_path
  end
end
