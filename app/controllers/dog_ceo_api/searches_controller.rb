module DogCeoApi
  class SearchesController < ::ApplicationController
    def create
      case Client.random_image(breed: search_params[:breed])
      in ::DogCeoApi::Client::Error => error
        render_flash_message_error(error)
      in ::DogCeoApi::Client::Dog => dog
        render_dog_photo(dog)
      end
    end

    private

    def search_params
      params.require(:search).permit(:breed)
    end

    def render_dog_photo(dog)
      render turbo_stream: turbo_stream.update(
        "dog-photo",
        partial: "main/photo",
        locals: { dog: }
      )
    end

    def render_flash_message_error(error)
      flash.now[:alert] = error.message

      render turbo_stream: [
        turbo_stream.replace("flash", partial: "application/flash_messages")
      ]
    end
  end
end
