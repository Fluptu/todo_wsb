class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update destroy ]
  before_action :authenticate_user!
  before_action :ensure_frame_response, only: %i[ new edit]

  def index
    @tasks = current_user.tasks.all if @tasks.blank?
    if params[:completed].present?
      if params[:completed] == 'Ukończone'
        @tasks = current_user.tasks.is_completed(true)
      elsif params[:completed] == 'Nieukończone'
        @tasks = current_user.tasks.is_completed(false)
      else
        @tasks = current_user.tasks.all
      end
    end
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url }
        format.json { render :show, status: :created, location: @task }
        flash[:notice] = "Dodano nowe zadanie"
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url}
        format.json { render :show, status: :ok, location: @task }
        flash[:notice] = "Zaktualizowane zadanie!"
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
      flash[:notice] = "Usunięto zadanie!"
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :body, :completed)
  end

  def ensure_frame_response
    redirect_to tasks_path unless turbo_frame_request?
  end
end
