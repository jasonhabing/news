require 'test_helper'

class WordStatsControllerTest < ActionController::TestCase
  setup do
    @word_stat = word_stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:word_stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create word_stat" do
    assert_difference('WordStat.count') do
      post :create, word_stat: { half_day_frequency: @word_stat.half_day_frequency, name: @word_stat.name, one_day_frequency: @word_stat.one_day_frequency, one_hour_frequency: @word_stat.one_hour_frequency, one_month_frequency: @word_stat.one_month_frequency, one_week_frequency: @word_stat.one_week_frequency, quarter_day_frequency: @word_stat.quarter_day_frequency }
    end

    assert_redirected_to word_stat_path(assigns(:word_stat))
  end

  test "should show word_stat" do
    get :show, id: @word_stat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @word_stat
    assert_response :success
  end

  test "should update word_stat" do
    patch :update, id: @word_stat, word_stat: { half_day_frequency: @word_stat.half_day_frequency, name: @word_stat.name, one_day_frequency: @word_stat.one_day_frequency, one_hour_frequency: @word_stat.one_hour_frequency, one_month_frequency: @word_stat.one_month_frequency, one_week_frequency: @word_stat.one_week_frequency, quarter_day_frequency: @word_stat.quarter_day_frequency }
    assert_redirected_to word_stat_path(assigns(:word_stat))
  end

  test "should destroy word_stat" do
    assert_difference('WordStat.count', -1) do
      delete :destroy, id: @word_stat
    end

    assert_redirected_to word_stats_path
  end
end
