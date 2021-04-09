class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # これで特定のレコードを取得できる。詳しくはprototypesコントローラー参照
  end
end
