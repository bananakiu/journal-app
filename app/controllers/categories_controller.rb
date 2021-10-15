class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:show, :edit, :update, :destory]

    def index
        # @categories = Category.all
        @categories = current_user.categories
    end

    def show
    end
    def new
        @category = current_user.categories.build
    end
    
    def create
        @category = current_user.categories.build(category_params)
    
        if @category.save
            redirect_to categories_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @category.update(category_params)
            redirect_to categories_path
        else
            render :edit
        end
    end

    def destroy
        correct_user # ? not sure why, but destroy doesn't work if I don't explicitly call correct_user here (even if I have a before_action)
        @category.destroy
    
        redirect_to categories_path
    end

    def correct_user
        @category = current_user.categories.find_by(id: params[:id])
        redirect_to categories_path, notice: "Not authorized to access/edit this." if @category.nil?
    end

    private        
        def category_params
            params.require(:category).permit(:title, :user_id)
        end
end
