class ChatsController < ApplicationController
    before_action :authenticate_user
    before_action :no_entry, {only: [:create]}
    
    def create
        @room = Room.find_by(id: params[:id])
        @chat = Chat.new(
            user_id: @current_user.id, 
            room_id: @room.id, 
            message: params[:message]
        )
        if @chat.save
            redirect_to("/rooms/#{@room.id}/index")
        else
            flash[:notice] = "メッセージ送信に失敗しました"
            render("rooms/#{@room.id}/index")
        end
    end


    #URLについてのコードレビュー終了。
    def no_entry
        @room = Room.find_by(id: params[:id])
        if @room
            @user1 = User.find_by(id: @room.user_to)
            @user2 = User.find_by(id: @room.user_from)
            if @user1.id != @current_user.id && @user2.id != @current_user.id
                flash[:notice] = "権限がありません"
                redirect_to("/users/#{@current_user.id}")
            end
        else
            redirect_to("/users/#{@current_user.id}")
        end
    end


end