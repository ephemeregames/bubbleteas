class Api::BubbleTeasController < ApplicationController

  def index
    @bubble_teas = BubbleTea.all

    respond_with @bubble_teas
  end


  def chef_choices
    @bubble_teas = BubbleTea.where(chef_choice: true).all

    respond_with @bubble_teas
  end


  def top
    # TODO
    @bubble_teas = BubbleTea.all

    respond_with @bubble_teas
  end


  def show
    @bubble_tea = BubbleTea.find(params[:id])

    respond_with @bubble_tea
  end
  
  
  def update
    @bubble_tea = BubbleTea.find(params[:id])

    if @bubble_tea.update_attributes(params[:bubble_tea])
      respond_with(@bubble_tea)
    else
      respond_with(@bubble_tea, status: :unprocessable_entity)
    end
  end


  def destroy
    @bubble_tea = BubbleTea.find(params[:id])

    if @bubble_tea.destroy
      respond_with(@bubble_tea)
    else
      respond_with(@bubble_tea, status: :unprocessable_entity)
    end
  end


  def create
    params[:bubble_tea]['ingredients_attributes'] = {}

    params[:ingredients].each_with_index do |ingredient, i|
      params[:bubble_tea]['ingredients_attributes'][i] = { ingredient_id: ingredient['id'] }
    end

    @bubble_tea = BubbleTea.new(params[:bubble_tea])

    if @bubble_tea.save
      respond_with(@bubble_tea, location: api_bubble_tea_path(@bubble_tea))
    else
      respond_with(@bubble_tea, status: :unprocessable_entity)
    end
  end

end