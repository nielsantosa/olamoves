class GoalsController < ApplicationController
  def index
    @user = current_user
    @goals = Goal.where(user: @user)
    @goal = Goal.new
  end

  def create
    @user = current_user
    @goal = Goal.new(user: @user, description: params[:goals])
    @goal.save
    redirect_to goals_path(@user)
  end
end
