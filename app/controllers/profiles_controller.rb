class ProfilesController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_user, {only: [:edit, :update]}


    def new
      @profile = Profile.new
    end
    
    def edit
      @profile = Profile.find_by(user_id: params[:id])
    end
    
    def create
      @profile = Profile.new(
        user_id: @current_user.id,
        current: params[:current],
        occupation: params[:occupation],
        introduction: params[:introduction],
        ability: params[:ability],
        career: params[:career]
      )
      if @profile.save
        flash[:notice] = "プロフィール登録が完了しました"
        redirect_to("/users/#{@current_user.id}/profile")
      else
        flash[:notice] = "プロフィール登録ができませんでした。空欄がある場合は埋めるか、記載することがない場合は「なし」や「記載なし」と書いてもう一度登録ボタンを押してください。"
        render("profiles/new")
      end
    end
    
    def update
      @profile = Profile.find_by(user_id: params[:id])
      @profile.current = params[:current]
      @profile.occupation = params[:occupation]
      @profile.introduction = params[:introduction]
      @profile.ability = params[:ability]
      @profile.career = params[:career]
  
      if @profile.save
        flash[:notice] = "プロフィール情報を編集しました"
        redirect_to("/users/#{@current_user.id}/profile")
      else
        flash[:notice] = "プロフィールを編集できませんでした。空欄がある場合は埋めるか、記載することがない場合は「なし」や「記載なし」と書いてもう一度登録ボタンを押してください。"
        render("profiles/edit")
      end
    end


    def ensure_correct_user
        if @current_user.id != params[:id].to_i
          flash[:notice] = "権限がありません"
          redirect_to("/posts/index")
        end
    end

    #URLについてのコードレビュー終了。
    
end