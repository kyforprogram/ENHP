class Users::RoomsController < ApplicationController
  def index
    my_room_ids = current_user.entries.pluck(:room_id)
    @another_entries = Entry.includes(:room, :user).where(room_id: my_room_ids).where.not(user_id: current_user.id)
  end
end
