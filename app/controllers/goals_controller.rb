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
    redirect_to goals_path(@user)
  end

  def update
    @user = current_user
    @goal = Goal.find(params[:id])
    @goal.completed = true
    @goal.date = Time.now
    @goal.save
    redirect_to goals_path(@user)
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_path(@user)
  end
end
