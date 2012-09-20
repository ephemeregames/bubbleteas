class Api::IngredientCategoriesController < ApplicationController

  def index
    @categories = IngredientCategory.all

    respond_with(@categories)
  end


  def show
    @category = IngredientCategory.find(params[:id])

    respond_with(@category)
  end


  def update
    @category = IngredientCategory.find(params[:id])

    if @category.update_attributes(params[:ingredient_category])
      respond_with(@category)
    else
      respond_with(@category, status: :unprocessable_entity)
    end
  end


  def destroy
    @category = IngredientCategory.find(params[:id])

    if @category.destroy
      respond_with(@category)
    else
      respond_with(@category, status: :unprocessable_entity)
    end
  end


  def create
    @category = IngredientCategory.new(params[:ingredient_category])

    if @category.save
      respond_with(@category, location: api_ingredient_category_path(@category))
    else
      respond_with(@category, status: :unprocessable_entity)
    end
  end

end
