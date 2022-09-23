class SpicesController < ApplicationController
  def index
    render json: Spice.all, except: [:created_at, :updated_at]
  end

  def show
      spice = Spice.find_by(id: params[:id])

      if spice
          render json: spice, status: :found, except: [:created_at, :updated_at]
      else
          spice_not_found
      end
  end

  def create
      spice = Spice.create(spice_params)
      render json: spice
  end

  def update
      spice = Spice.find_by(id: params[:id])

      if spice
          spice.update(spice_params)
      else
          spice_not_found
      end
  end

  def destroy
      spice = Spice.find_by(id: params[:id])

      if spice
          spice.destroy
          head :no_content
      else
          spice_not_found
      end
  end

  private

  def spice_params
      params.permit(:title, :image, :description, :notes, :rating)
  end

  def spice_not_found
      render json: {error: "spice not found"}
  end
end
