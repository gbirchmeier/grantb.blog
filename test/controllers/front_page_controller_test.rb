class FrontPageControllerTest < ActionController::TestCase

  def setup
    @test_post = []
    (0..15).each do |i|
      @test_post[i] = FactoryGirl.create(:post,published_at:DateTime.new(2015,1,i+1))
    end
  end

  test "index" do
    get :index
    assert_equal 10, assigns(:posts).length
    assert_equal @test_post[15], assigns(:posts).first
    assert_equal @test_post[6], assigns(:posts).last
    assert_equal @test_post[6].published_at.to_i, assigns(:older_time)
  end

  test "before" do
    get :before, timeint: @test_post[13].published_at.to_i
    assert_equal 10, assigns(:posts).length
    assert_equal @test_post[12], assigns(:posts).first
    assert_equal @test_post[3], assigns(:posts).last
    assert_equal @test_post[3].published_at.to_i, assigns(:older_time)
    assert_equal @test_post[12].published_at.to_i, assigns(:newer_time)
  end

  test "after" do
    get :after, timeint: @test_post[2].published_at.to_i
    assert_equal 10, assigns(:posts).length
    assert_equal @test_post[12], assigns(:posts).first
    assert_equal @test_post[3], assigns(:posts).last
    assert_equal @test_post[3].published_at.to_i, assigns(:older_time)
    assert_equal @test_post[12].published_at.to_i, assigns(:newer_time)
  end

  test "before - truncated" do
    get :before, timeint: @test_post[4].published_at.to_i
    assert_equal 4, assigns(:posts).length
    assert_equal @test_post[3], assigns(:posts).first
    assert_equal @test_post[0], assigns(:posts).last
    assert_nil assigns(:older_time)
    assert_equal @test_post[3].published_at.to_i, assigns(:newer_time)
  end

  test "after - redirect to front" do
    get :after, timeint: @test_post[12].published_at.to_i
    assert_response 302
  end

end
