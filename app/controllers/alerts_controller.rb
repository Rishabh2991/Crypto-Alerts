class AlertsController < ApplicationController
  def index
    @user_alerts = Alert.where(user_id: current_user.id)
  end

  def new
    @alert = Alert.new
  end

  def create
    payload = {
      user_id: current_user.id,
      target_price: params.dig("alert","target_price")
    }
    @new_alert = Alert.new(payload)
    if @new_alert.save
      redirect_to :alerts_page
    else
      render :new, status: :unprocessable_entity
    end
  end
end