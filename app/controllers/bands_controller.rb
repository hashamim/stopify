class BandsController < ApplicationController
    def index
        render :index
    end

    def create
        @band = Band.new(band_params)
        if @band.save
            redirect_to bands_url
        else
            flash.now[:errors] = @band.errors.full_messages
            render :new
        end
    end

    def new
        render :new
    end

    def edit
    end
    
    def update
    end

    def destroy
        b = Band.find_by(id: params[:id])
        b.delete
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end
end
