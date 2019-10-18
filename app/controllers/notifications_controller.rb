class NotificationsController < ApplicationController

  def index
    @notifications = Notification.all
    @notifications.each do |notification|
      notification.update read: true
    end
  end
end
