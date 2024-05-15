module DogCeoApi
  module Client
    extend self

    def random_image(breed:)
      breed => ::String

      response = connection.get("breed/#{breed}/images/random")

      case response.body
      in {status: "error", message: message, code: 404}
        { error: message }
      in { status: "success", message: photo_url}
        {
          data: { photo_url: photo_url }
        }
      end
    end

    private

    API_BASE = "https://dog.ceo/api".freeze

    def connection
      ::Faraday.new(
        url: API_BASE,
        headers: { "Content-Type" => "application/json" }
      ) do |builder|
        builder.request :json
        builder.response :json, parser_options: { symbolize_names: true }
      end
    end
  end
end
