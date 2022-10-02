class ConnectsController < ApplicationController
  before_action :authenticate_user
  before_action :request_check, {only: [:allow, :refuse]}
  before_action :cannot_myself, {only: [:requesting]}
  
  def requesting
    @user = User.find_by(id: params[:id])
    #すでに繋がっていた場合、つながり申請できないようにする。
    @connect1 = Connect.find_by(connecting_id: @user.id, connected_id: @current_user.id)
    @connect2 = Connect.find_by(connecting_id: @current_user.id, connected_id: @user.id)
    @request = Request.find_by(requesting_id: @user.id, requested_id: @current_user.id)
    if @connect1 || @connect2 then
      flash[:notice] = "すでに繋がっています"
      redirect_to("/users/#{@user.id}")
    elsif @request  then
      flash[:notice] = "このユーザーからはつながり申請が来ています。つながり承認を押してください。"
      redirect_to("connects/#{@current_user.id}/requesting")
    else
      @request = Request.new(
        requesting_id: @current_user.id, 
        requested_id: @user.id
      )
      if @request.save
      	flash[:notice] = "つながり申請をしました"
      	redirect_to("/users/#{@user.id}")
      else
        flash[:notice] = "つながり申請できませんでした"
        redirect_to("/users/#{@user.id}")
      end
    end
  end
  
  def allow
    @user = User.find_by(id: params[:id])
    @connect = Connect.new(connecting_id: @user.id, connected_id: @current_user.id)
    if @connect.save
      @request = Request.find_by(requesting_id: @user.id, requested_id: @current_user.id)
      @request.destroy
      flash[:notice] = "つながりました"
      redirect_to("/users/#{@current_user.id}/connected")
    end
  end
  
  def refuse
    @user = User.find_by(id: params[:id])
    @request = Request.find_by(requesting_id: @user.id, requested_id: @current_user.id)
    @request.destroy
    flash[:notice] = "つながりを拒否しました"
    redirect_to("/users/#{@current_user.id}/connected")
  end

  #リクエストがあった場合のみ、つながりを「allow」、「refuse」できる。
  def request_check
    @user = User.find_by(id: params[:id])
    @request = Request.find_by(requesting_id: @user.id, requested_id: @current_user.id)
    if @request
        redirect_to("connects/#{@user.id}/allow")
    else
        redirect_to("/posts/index")
    end

  end

  #「requesting」に関して、自分自身にはリクエストできないようにするメソッド。
  def cannot_myself
    @user = User.find_by(id: params[:id])
    if @user.id == @current_user.id
        redirect_to("/posts/index")
    end
  end

  #URLについてのコードレビュー終了。

  
end