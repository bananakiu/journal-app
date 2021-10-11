class TasksController < ApplicationController
    before_action :set_category
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        redirect_to @category
    end

    def show
    end
    
    def new
        @task = @category.tasks.new
    end
    
    def create
        @task = @category.tasks.new(task_params)
        if @task.save
            redirect_to category_path(@category)
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
            # redirect_to @task
            redirect_to category_path(@category)
        else
            render :edit
        end
    end

    def destroy
        @task.destroy
        redirect_to category_path(@category)
    end
    
    private
        def set_category
            @category = current_user.categories.find_by(id: params[:category_id])
            redirect_to categories_path, notice: "Not authorized to access/edit this." if @category.nil?
        end

        def set_task
            @task = @category.tasks.find(params[:id])
        end

        def task_params
            params.require(:task).permit(:name, :notes, :date, :complete)
        end
end