require 'fileutils'

class RecipesController < ApplicationController
  def index
    # Initialisation of variable @recipes
    @recipes = Recipe.all

    # Apply all filters to @recipes if any queries are present
    @recipes = @recipes.where("preparation_time <= ?", params[:preparation_time].to_i) if params[:preparation_time].present?
    @recipes = @recipes.where(difficulty: params[:difficulty].to_i) if params[:difficulty].present?

    if params[:ingredient].present?
      # Filter by ingredients by name
      @recipes = @recipes.joins(:ingredients).where("ingredients.name ILIKE ?", "%#{params[:ingredient]}%").distinct
    end

    # If no queries are present, limit the results to 10
    @recipes = @recipes.limit(10) if params[:preparation_time].blank? && params[:difficulty].blank? && params[:ingredient].blank?
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Recette créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recette mise à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: "Recette supprimée."
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :title, :description, :image, :preparation_time, :difficulty,
      ingredients_attributes: [:id, :name, :quantity, :_destroy],
      utensils_attributes: [:id, :name, :_destroy],
      steps_attributes: [:id, :description, :position, :_destroy]
    )
  end

end
