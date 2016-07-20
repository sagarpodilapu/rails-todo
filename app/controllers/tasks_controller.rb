class TasksController < ApplicationController
  before_action :get_task, only: [:edit,:update,:destroy,:show]
  #before_action :check_auth, only: [:edit,:update,:destroy]

  def index
    # show all tasks
    @tasks = Task.where("ended_on < started_on AND user_id = ?",current_user.id).order("started_on DESC");
  end

  def show
    respond_to do |format|
      format.html #show.html.erb
      format.json {render json:@task}
      format.xml {render xml:@task}
    end
  end
  def new
    # show a new task form
    @tasks = Task.new
    @users = User.count
    if @users == 0
      flash[:notice] = "No users found. Add user first"
      redirect_to new_user_path
    end
  end

  def edit
    # show a edit task form
    @task.ended_on = Time.now
    @task.save
    redirect_to root_path

  end
  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    # udpate a task
    if @task.update_attributes(task_params)
      # Handle a successful update.
      redirect_to(tasks_path)
    else
      render 'edit'
    end
  end
  def destroy
    # delete a task
    @task.destroy
    flash[:success] = "Task deleted"
    redirect_to tasks_path
  end

  def completed
    @tasks = Task.where("ended_on >= started_on AND user_id = ?",current_user.id).order("ended_on DESC");;

  end

  private

  def task_params
    params.require(:task).permit(:user_id, :task, :ended_on)
  end

  def get_task
    @task = Task.find(params[:id])
  end

  def check_auth
    if session[:user_id] != @task.user_id
      flash[:notice] = "Sorry! You cannot edit this task"
      redirect_to(tasks_path)
    end
  end
end
