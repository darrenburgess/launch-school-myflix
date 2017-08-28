class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def show
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
