class Api::IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all

    respond_with @ingredients
  end


  def show
    @ingredient = Ingredient.find(params[:id])

    respond_with @ingredient
  end
  
  
  def update
    @ingredient = Ingredient.find(params[:id])

    if @ingredient.update_attributes(params[:ingredient])
      respond_with(@ingredient)
    else
      respond_with(@ingredient, status: :unprocessable_entity)
    end
  end


  def destroy
    @ingredient = Ingredient.find(params[:id])

    if @ingredient.destroy
      respond_with(@ingredient)
    else
      respond_with(@ingredient, status: :unprocessable_entity)
    end
  end


  def create
    @ingredient = Ingredient.new(params[:ingredient])

    if @ingredient.save
      respond_with(@ingredient, location: api_ingredient_path(@ingredient))
    else
      respond_with(@ingredient, status: :unprocessable_entity)
    end
  end

end