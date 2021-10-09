class TasksController < ApplicationController
    def new
        @category = Category.find(params[:category_id])
        @task = @category.tasks.new
    end
    
    def create
        @category = Category.find(params[:category_id])
        @task = @category.tasks.new(task_params)
        if @task.save
            redirect_to category_path(@category)
        else
            render :new
        end
    end

    def destroy
        @category = Category.find(params[:category_id])
        @task = @category.tasks.find(params[:id])
        @task.destroy
        redirect_to category_path(@category)
    end
    
    private
        def task_params
            params.require(:task).permit(:name, :notes, :date, :complete)
        end
end