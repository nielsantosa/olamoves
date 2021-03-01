class GoalsController < ApplicationController
  def index

    @goal = Goal.new
    user = current_user
    @goals_completed = Goal.where(user: user, completed: true)
    @goals_current = Goal.where(user: user, completed: false)
  end

  def create
    @user = current_user
    @goal = Goal.new(params.require(:goal).permit(:description))
    @goal.user = current_user
    @goal.date = Time.now
    @goal.save
    redirect_to goals_path
  end

  def edit
    @user = current_user
    @goal = Goal.find(params[:id])
  end

  def update
    @user = current_user
    @goal = Goal.find(params[:id])
    @goal.completed = true
    @goal.date = Time.now
    @goal.save
    redirect_to goals_path
  end

  def comment
    @user = current_user
    @goal = Goal.find(params[:id])
    @goal.comment = params.require(:goal).require(:comment)
    if @goal.save
      redirect_to goals_path
    else
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_path
  end
end
