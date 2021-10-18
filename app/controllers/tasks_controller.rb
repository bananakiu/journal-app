class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, except: [:list]
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index        
        # get all tasks in categories belonging to current_user
        @tasks = @category.tasks

        # get specific lists of tasks
        @tasks_today = @tasks.where("date >= ? and date < ?", Date.current, Date.current+1).order("date, category_id")
        @tasks_overdue = @tasks.where("date < ?", Date.current).order("date, category_id")
        @tasks_no_date = @tasks.where(date: nil).order("category_id")
        @tasks_after_today = @tasks.where("date > ?", Date.current).order("date")
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

    # GET /tasks
    def list
        # get categories the user owns
        @categories = current_user.categories
        redirect_to categories_path, notice: "Not authorized to access/edit this." if @categories.nil?
        
        # get all tasks in categories belonging to current_user
        @tasks = Task.where(category_id: [@categories.select(:id)])#.order("date DESC, category_id")

        # get specific lists of tasks
        @tasks_today = @tasks.where("date >= ? and date < ?", Date.current, Date.current+1).order("date, category_id")
        @tasks_overdue = @tasks.where("date < ?", Date.current).order("date, category_id")
        @tasks_no_date = @tasks.where(date: nil).order("category_id")
        @tasks_after_today = @tasks.where("date > ?", Date.current).order("date")
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