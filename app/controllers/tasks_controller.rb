class TasksController < ApplicationController

  def index
    if params[:task].present?
      params_title = params[:task][:title]
      params_status = params[:task][:status]
      if params[:task][:title].present? && params[:task][:status].present?
        # @tasks = Task.where("title LIKE ?", "%#{params[:task][:title]}%").where(status: params[:task][:status])
        @tasks = Task.title_and_status_search(params_title,params_status)
      elsif params[:task][:title].present?
        # @tasks = Task.where("title LIKE ?", "%#{params[:task][:title]}%")
        @tasks = Task.title_search(params_title)
      elsif params[:task][:status].present?
        # @tasks = Task.where(status: params[:task][:status])
        @tasks = Task.status_search(params_status)
      end
    elsif params[:sort_expired].present?
      # @tasks = Task.all.order(expired_at: :DESC)
      @tasks = Task.expired_list
    elsif params[:sort_priority].present?
      @tasks = Task.priority_list
    else
      # @tasks = Task.all.order(created_at: :DESC)
      @tasks = Task.created_list
    end
  end

  def new
    @task = Task.new

  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end

end
