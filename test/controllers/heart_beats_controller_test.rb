require 'test_helper'

class HeartBeatsControllerTest < ActionController::TestCase
  setup do
    @heart_beat = heart_beats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:heart_beats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create heart_beat" do
    assert_difference('HeartBeat.count') do
      post :create, heart_beat: { heart_beat: @heart_beat.heart_beat, intensity: @heart_beat.intensity }
    end

    assert_redirected_to heart_beat_path(assigns(:heart_beat))
  end

  test "should show heart_beat" do
    get :show, id: @heart_beat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @heart_beat
    assert_response :success
  end

  test "should update heart_beat" do
    patch :update, id: @heart_beat, heart_beat: { heart_beat: @heart_beat.heart_beat, intensity: @heart_beat.intensity }
    assert_redirected_to heart_beat_path(assigns(:heart_beat))
  end

  test "should destroy heart_beat" do
    assert_difference('HeartBeat.count', -1) do
      delete :destroy, id: @heart_beat
    end

    assert_redirected_to heart_beats_path
  end
end
