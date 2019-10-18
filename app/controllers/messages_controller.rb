class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)
    create_notifications(@conversation)
    respond_to do |format|
      format.js
    end
  end

  def create_notifications(conversation)
    if conversation.recipient_id == current_user.id
      recipient_id = conversation.sender_id
    else
      recipient_id = conversation.recipient_id
    end
    Notification.create(user_id: recipient_id, notified_by_id: current_user.id, notice_type: 'New Message')
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end
