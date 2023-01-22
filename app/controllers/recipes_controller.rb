class RecipesController < ApplicationController

    def index
        return render json: { errors: ["Not authorized"] }, status: 401 unless session.include? :user_id
        # user = User.find_by(:id session[:user_id])
        render json: Recipe.all, status: 201
    end

    def create
        return render json: { errors: ["Not authorized"] }, status: 401 unless session.include? :user_id
        user = User.find_by(id: session[:user_id])
        recipe = user.recipes.new(recipe_params)
        if recipe.valid?
            recipe.save
            render json: recipe, status: 201
        else
            render json: { errors: recipe.errors.full_messages }, status: 422
        end
    end


    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
