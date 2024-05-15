module DogCeoApi
  class ClientTest < ActiveSupport::TestCase
    test "random_image when the breed doesn't exists" do
      response = VCR.use_cassette("breed/not_exists") do
        ::DogCeoApi::Client.random_image(breed: "Cachorro")
      end

      assert_equal({ error: "Breed not found (master breed does not exist)" }, response)
    end

    test "random_image when the breed exists" do
      response = VCR.use_cassette("breed/exists") do
        ::DogCeoApi::Client.random_image(breed: "hound")
      end

      assert_equal({ data: { photo_url: "https://images.dog.ceo/breeds/hound-blood/n02088466_2030.jpg" } }, response)
    end
  end
end
