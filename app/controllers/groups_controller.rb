class GroupsController < ApplicationController
  
  before_filter :require_user
  
  def index
    @groups = Group.find(:all)
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(params[:group])
    @group.user = current_user
    if @group.save
      redirect_to groups_path
    else
      render :action => :new
    end
  end
  
  def destroy
    @group = Group.find(params[:id])
    if params[:recipient_id]
      @recipient = Recipient.find(params[:recipient_id])
      @recipient.groups.delete(@group)
      redirect_to edit_recipient_path(@recipient)
    elsif params[:message_id]
      @message = Message.find(params[:message_id])
      @message.groups.delete(@group)
      redirect_to edit_message_path(@message)
    else
      @group.destroy
      redirect_to groups_path
    end
  end
  
end