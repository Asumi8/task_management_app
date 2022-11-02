class TasksController < ApplicationController
  skip_before_action :forbid_login_user, only:[:index, :new, :create, :update, :show, :edit, :destroy]
  skip_before_action :prohibit_access_to_other_users, only:[:index, :new, :create, :update, :show, :edit, :destroy]

  def index
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if title.present? && status.present?
        @tasks = Task.page(params[:page]).title_and_status_search(title, status)
      elsif title.present?
        @tasks = Task.page(params[:page]).title_search(title)
      elsif status.present?
        @tasks = Task.page(params[:page]).status_search(status)
      end
    elsif params[:sort_expired].present?
      @tasks = Task.page(params[:page]).expired_list
    elsif params[:sort_priority].present?
      @tasks = Task.page(params[:page]).priority_list
    else
      @tasks = Task.page(params[:page]).created_list
    end
  end

  def new
    @task = Task.new

  end

  def create
    @task = current_user.tasks.build(task_params)
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
