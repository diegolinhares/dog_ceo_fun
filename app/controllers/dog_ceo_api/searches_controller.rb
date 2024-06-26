module DogCeoApi
  class SearchesController < ::ApplicationController
    def create
      breed = search_params[:breed].strip.gsub(" ", "/").downcase

      if breed.blank?
        return render_flash_message_error("Breed cannot be blank")
      end

      case Client.random_image(breed:)
      in ::DogCeoApi::Client::Error => _error
        render_flash_message_error("Breed not found")
      in ::DogCeoApi::Client::Dog => dog
        render_dog_photo(dog)
      end
    end

    private

    def search_params
      params.require(:search).permit(:breed)
    end

    def render_dog_photo(dog)
      flash.now[:notice] = "Breed found!"

      render turbo_stream: [
        turbo_stream.update("flash", partial: "application/flash_messages"),
        turbo_stream.update(
          "dog-photo",
          partial: "main/photo",
          locals: { dog: }
        )
      ]
    end

    def render_flash_message_error(error)
      flash.now[:alert] = error

      render turbo_stream: [
        turbo_stream.update("dog-photo"),
        turbo_stream.update("flash", partial: "application/flash_messages")
      ]
    end
  end
end
