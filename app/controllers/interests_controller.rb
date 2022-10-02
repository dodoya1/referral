class InterestsController < ApplicationController
    before_action :authenticate_user
    before_action :not_for_you, {only: [:create]}
  
    def create
      
      @offer = Offer.find_by(id: params[:id])
      
      #すでに「興味がある」というボタンを押していた場合。
      @interested = Interest.find_by(offer_id: @offer.id, user_id: @current_user.id)
      
      if @interested
        flash[:notice] = "すでに、話を聞きたい！と投稿者に伝えています"
      else
        
        @interest = Interest.new(
          offer_id: @offer.id,
          user_id: @current_user.id
        )
        
        if @interest.save
          flash[:notice] = "話を聞きたい！と投稿者に伝えました。投稿者からDMが来るかもしれません。"
          redirect_to("/offers/index")
        else
        end
        
      end
      
    end
  

    #「create」メソッドに関して、限定公開の場合、URLを直接打つことで「話を聞きたい！」とできないようにするメソッド。
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

    #URLについてのコードレビュー終了。
    
end