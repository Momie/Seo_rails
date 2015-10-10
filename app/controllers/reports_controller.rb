class ReportsController < ApplicationController

	before_action :authenticate_user!

  def create
  	if current_user
        Report.create(:user_id=>current_user.id)
    end
    redirect_to action: :index
  end

  def index
  	@reports = current_user.reports
  end

  def show
  	@report = Report.find(params[:id])
  end
end
