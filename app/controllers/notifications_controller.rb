class NotificationsController < ApplicationController

  def index
    @notifications = Notification.all
    @notifications.each do |notification|
      notification.update read: true
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
    end
  end
end
