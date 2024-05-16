module DogCeoApi
  class ClientTest < ActiveSupport::TestCase
    test "random_image when the breed doesn't exists" do
      result = VCR.use_cassette("breed/not_exists") do
        ::DogCeoApi::Client.random_image(breed: "Cachorro")
      end

      error = ::DogCeoApi::Client::Error["Breed not found (master breed does not exist)"]

      assert_equal(error, result)
    end

    test "random_image when the breed exists" do
      result = VCR.use_cassette("breed/exists") do
        ::DogCeoApi::Client.random_image(breed: "hound")
      end

      dog = ::DogCeoApi::Client::Dog["https://images.dog.ceo/breeds/hound-blood/n02088466_2030.jpg"]

      assert_equal(dog, result)
    end
  end
end
