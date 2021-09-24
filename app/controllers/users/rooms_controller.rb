class Users::RoomsController < ApplicationController
  def index
    @entries = current_user.entries.joins(:direct_messages).includes(:messages).order("messages.created_at DESC")
  end


end
