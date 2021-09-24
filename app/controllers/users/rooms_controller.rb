class Users::RoomsController < ApplicationController

  def index
    # my_room_ids = current_user.entries.pluck(:room_id)
    # @another_entries = Entry.includes(:room, :user).where(room_id: my_room_ids).where.not(user_id: current_user.id)
    my_entry_rooms = current_user.entries.pluck(:room_id)
    @entries = Entry.includes(:room, :user).where(room_id: my_entry_rooms).where.not(user_id: current_user)
  end
end
