class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update,:requested,:connected]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update, :rooms, :offers]}
  before_action :invisible_requested, {only: [:requested]}
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def login_form
  end
  
  def login
    # メールアドレスのみを用いて、ユーザーを取得するように書き換えてください
    @user = User.find_by(email: params[:email])
    # if文の条件を&&とauthenticateメソッドを用いて書き換えてください
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end
  
  
  
  
  def requested
    @user = User.find_by(id: params[:id])
    #たとえば、ユーザー1のユーザー詳細ページで、ユーザー1に申請したユーザー一覧を表示させる。
    #ここで、@requestedはユーザー1
    @requested = Request.where(requested_id: @current_user.id)
  end
  
  def connected
    @user = User.find_by(id: params[:id])
    @connects = Connect.where(connecting_id: @user.id)
    #1が2、2が1。両方において検索する必要がある。今のところ。
    @connects2 = Connect.where(connected_id: @user.id)
  end
  
  
  #「推薦コメント」一覧ページ。
  def recommends
    @user = User.find_by(id: params[:id])
    @recommends = Recommend.where(user_to: @user.id)
  end
  
  
  #「プロフィール」欄。
  def profile
    @user = User.find_by(id: params[:id])
    @profile = Profile.find_by(user_id: @user.id)
  end
  
  #あるユーザーの求人投稿一覧。
  def offers
    @user = User.find_by(id: params[:id])
  end
  
  
  #あるユーザーのDM一覧。
  def rooms
    @user = User.find_by(id: params[:id])
    if @user.id == @current_user.id
      @room1 = Room.where(user_to: @user.id)
      @room2 = Room.where(user_from: @user.id)
    end
    
  end
  
  
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
  #roomsメソッドについては、URLについてのコードレビュー終了。
  #他人のつながりリクエストの一覧、すなわち「"users/:id/requested"」は見れないようにするメソッド。
  def invisible_requested
    @user = User.find_by(id: params[:id])
    if @user.id != @current_user.id
        flash[:notice] = "権限がありません"
        redirect_to("/posts/index")
    end
  end


  #users_controller内のつながり機能(「requested」「connected」「offers」「profile」)に関連するメソッドは、URLについてのコードレビュー終了。
  #URLについてのコードレビュー終了。

end