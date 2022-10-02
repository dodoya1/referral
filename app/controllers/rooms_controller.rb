class RoomsController < ApplicationController
    before_action :authenticate_user
    before_action :no_entry, {only: [:index]}
    
    def investigating
        @user = User.find_by(id: params[:id])
        if @user
            @room1 = Room.find_by(user_to: @user.id, user_from: @current_user.id)
            @room2 = Room.find_by(user_to: @current_user.id, user_from: @user.id)
    
            #すでにユーザー同士のルームがあった場合、「"rooms/:id/index"」に飛び、
            #まだユーザー同士のルームがなかった場合、「"chats/:id/create"」に飛び、ルームを作成してから「"rooms/:id/index"」に飛ぶ。
            if @room1 then
                redirect_to("/rooms/#{@room1.id}/index")
            elsif @room2 then
                redirect_to("/rooms/#{@room2.id}/index")
            else
                @room = Room.new(user_to: @user.id, user_from: @current_user.id)
                @room.save
                redirect_to("/rooms/#{@room.id}/index")
            end
        else
            redirect_to("/users/#{@current_user.id}")
        end

    end


    def index
        @room = Room.find_by(id: params[:id])
        #チャットメッセージを一覧表示するため。html.erbで、「<% @chats.each do |chat| %>」のようにして表示する。
        @chats = Chat.where(room_id: @room.id)
        @chats2 = @chats.all.order(created_at: :desc)
        #チャットルームの相手のユーザーid。user_toかuser_fromかわからないので、どちらも変数に代入してどちらか調べる。
        @user1 = User.find_by(id: @room.user_to)
        @user2 = User.find_by(id: @room.user_from)

        if @user1.id != @current_user.id then
            @user = @user1
        elsif @user2.id != @current_user.id then
            @user = @user2
        else
            redirect_to("/users/#{@current_user.id}")
        end

    end

    #「"rooms/:id/index"」とURLを直接貼ることで、他人のroomに勝手に入れないようにするメソッド。
    #「if @user1 != @current_user.id && @user2 != @current_user.id」と書いて、期待通りの処理が行われなくて、悩んだ。結局、「.id」がなかっただけだった。
    #そもそも、そのidのroomがない場合の処理を追加した。以後、これを参考に！
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


    #URLについてのコードレビュー終了。

end