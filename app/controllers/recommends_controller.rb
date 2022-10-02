class RecommendsController < ApplicationController
  before_action :authenticate_user
  
  
  def create
    @user = User.find_by(id: params[:id])
    
    @recommend = Recommend.new(
      user_from: @current_user.id,
      user_to: @user.id,
      content: params[:content]
    )
    if @recommend.save
      flash[:notice] = "#{@user.name}さんに、推薦コメントを贈りました"
      redirect_to("/users/#{@user.id}/recommends")
    else
      flash[:notice] = "推薦コメントを贈れませんでした。#{@user.name}さんと繋がっていない場合は、繋がってからでないと推薦コメントは贈れません"
      render("/users/#{@user.id}")
    end
    
  end
  
  
  #つながりがあるか確認。
  def connecting
    @user = User.find_by(id: params[:id])
    @connecting = Connect.find_by(connecting_id: @user.id, connected_id: @current_user.id)
    @connecting2 = Connect.find_by(connecting_id: @current_user.id, connected_id: @user.id)
    
    if @connecting || @connecting2
      redirect_to("/recommends/#{@user.id}/comment")
    else
      flash[:notice] = "#{@user.name}さんとは繋がっていないので、推薦コメントを書くことはできません。"
      redirect_to("/users/#{@user.id}")
    end
    
  end
  
  def show
    @recommend = Recommend.find_by(id: params[:id])
    #その推薦コメントを書いたユーザーid。
    @user = @recommend.user
  end
  
  def destroy
    @recommend = Recommend.find_by(id: params[:id])
    #その推薦コメントを贈った人。「贈った人(@user) = @current_user.id」の場合、
    #その推薦コメントを削除できる。
    @user = @recommend.user_from
    @user_to = User.find_by(id: @recommend.user_to)
    
    #以下のif文の条件式があっているか少し不安
    if @user == @current_user.id
      @recommend.destroy
      flash[:notice] = "推薦コメントを削除しました"
      redirect_to("/users/#{@user_to.id}")
    else
      flash[:notice] = "推薦コメントは、書いた本人でないと削除できません。"
      redirect_to("/users/#{@user_to.id}")
    end
    
  end
  
  def comment
    #推薦コメントを贈られるユーザーのid。
    @user = User.find_by(id: params[:id])
  end

end