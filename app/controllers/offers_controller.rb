class OffersController < ApplicationController
    before_action :authenticate_user
    before_action :not_for_you, {only: [:show]}
    before_action :ensure_correct_user, {only: [:edit,:update, :destroy]}

    def new
      @offer = Offer.new
    end
    
    def create
      @setting = params[:setting].to_i
    
      @offer = Offer.new(
        content: params[:content],
        user_id: @current_user.id,
        setting: @setting,
        title: params[:title]
      )
      
      if @setting != 1 && @setting != 2 then
        flash[:notice] = "公開設定を1か2の半角数字で入力してください"
        render("posts/new")
      elsif @offer.save then
        flash[:notice] = "求人投稿を作成しました"
        redirect_to("/offers/index")
      else
        flash[:notice] = "全ての欄を埋めましたか？もう一度記載事項をよく読んで入力して下さい"
        render("posts/new")
      end
      
    end
    
    def index
      @offers = Offer.all.order(created_at: :desc)
    end
    
    #少々設計に悩んだ。html.erbとセットで処理が完成されるみたいな。
    def show
      @offer = Offer.find_by(id: params[:id])
      #「@user」は、求人投稿を作成したユーザー。
      @user = @offer.user
      #その求人投稿に対して、興味を示したユーザー。
      @offerid = Interest.where(offer_id: @offer.id)
    end
    
    def edit
      @offer = Offer.find_by(id: params[:id])
    end
    
    #これも少々設計に時間がかかった。
    def update
      @offer = Offer.find_by(id: params[:id])
      @setting = params[:setting].to_i
    
      if @setting != 1 && @setting != 2 then
        flash[:notice] = "公開設定を1か2の半角数字で入力してください"
        render("offers/edit")
      elsif @setting == 1 || @setting == 2 then
        @offer.title = params[:title]
        @offer.content = params[:content]
        @offer.setting = @setting
        if @offer.save
          flash[:notice] = "求人投稿を編集しました"
          redirect_to("/offers/index")
        else
          render("offers/edit")
        end
      else
        flash[:notice] = "全ての欄を埋めましたか？もう一度記載事項をよく読んで入力して下さい"
        render("offers/edit")
      end
      
    end
    
    def destroy
      @offer = Offer.find_by(id: params[:id])
      @offer.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to("/offers/index")
    end
    
    #settingが1で、つながりがない場合、表示できないようにbeforeで動作させるメソッド。
    def invisible_post
    end

    #「show」メソッドに関して、限定公開の場合、URLを直接打つことでみることのできないようにするメソッド。
    def not_for_you
        @offer = Offer.find_by(id: params[:id])
        @setting = @offer.setting
        #「@user」は、求人投稿を作成したユーザー。
        @user = @offer.user

        if @setting == "1"
            @connect1 = Connect.find_by(connecting_id: @current_user.id, connected_id: @user.id)
            @connect2 = Connect.find_by(connecting_id: @user.id , connected_id: @current_user.id)
            if @connect1.nil? && @connect2.nil?
                redirect_to("/offers/index")
            end
        end

    end


    #他人の求人募集を「edit」「update」「destroy」できないようにするメソッド。
    def ensure_correct_user
        @offer = Offer.find_by(id: params[:id])
        if @offer.user_id != @current_user.id
          flash[:notice] = "権限がありません"
          redirect_to("/offers/index")
        end
    end

    #URLについてのコードレビュー終了。

    
end