require 'fileutils'

class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    
    # Filtrer les recettes en fonction des paramètres de recherche
    if params[:preparation_time].present?
      @recipes = @recipes.where("preparation_time <= ?", params[:preparation_time].to_i)
    end

    # Filtrer les recettes en fonction des paramètres de difficulté
    if params[:difficulty].present?
      @recipes = @recipes.where(difficulty: params[:difficulty].to_i)
    end

    if params[:ingredient].present?
      # Filtrer par ingrédient en effectuant une jointure sur le modèle Ingredient
      @recipes = @recipes.joins(:ingredients).where("ingredients.name ILIKE ?", "%#{params[:ingredient]}%").distinct
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if params[:recipe][:image].present?
      handle_image_upload
    end

    if @recipe.save
      redirect_to @recipe, notice: "Recette créée avec succès."
    else
      # Si la sauvegarde échoue, rendez le formulaire de création avec les erreurs
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if params[:recipe][:image].present?
      handle_image_upload
    end

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

  def handle_image_upload
    unique_filename = "#{SecureRandom.uuid}_#{params[:recipe][:image].original_filename}"
    uploads_dir = Rails.root.join("public/uploads/imgs")

    # Crée le répertoire si il n'existe pas
    FileUtils.mkdir_p(uploads_dir) unless File.directory?(uploads_dir)

    filepath = Rails.root.join(uploads_dir, unique_filename)

    # Sauvegarde le fichier
    File.open(filepath, "wb") do |file|
      file.write(params[:recipe][:image].read)
    end

    # Assigne le nom du fichier unique à l'attribut image de la recette
    @recipe.image = unique_filename
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :title, :description, :image, :preparation_time, :difficulty,
      ingredients_attributes: [:id, :name, :quantity, :_destroy],
      utensils_attributes: [:id, :name, :_destroy],
      steps_attributes: [:id, :description, :position, :_destroy]
    )
  end

end
