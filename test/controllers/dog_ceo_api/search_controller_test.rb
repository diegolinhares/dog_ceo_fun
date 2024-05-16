require "test_helper"

class DogCeoApi::SearchesControllerTest < ::ActionDispatch::IntegrationTest
  test "should render dog photo on successful search" do
    VCR.use_cassette("breed/exists") do
      post dog_ceo_api_searches_url, params: { search: { breed: "hound" } }, as: :turbo_stream
    end

    assert_response :success
    assert_select "turbo-stream[action=update][target=dog-photo]" do
      assert_select "template"
    end
  end

  test "should render flash error on search failure" do
    VCR.use_cassette("breed/not_exists") do
      post dog_ceo_api_searches_url, params: { search: { breed: "Cachorro" } }, as: :turbo_stream
    end

    assert_response :success
    assert_select "turbo-stream[action=replace][target=flash]" do
      assert_select "template"
    end
    assert_match "Breed not found", flash[:alert]
  end
end
