class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
      # comment変数の中で新しいインスタンスを作成。インスタンスの中にはprototype_idも含まれているので、引数にprototypeと書き込む事でidとして取得し、どのprototypeに対するコメントなのかを判別し、そこにリダイレクトする
      # コメントが所属しているプロトタイプを指定するといってもいいかも
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      # ここでは＠prototypeで指定したプロトタイプに紐づくコメントを全て取得している。アソシエーションで繋がっているので可能
      render "prototypes/show"
      # 別ディレクトリの部分テンプレートを呼び出しているため、ディレクトリ名/ファイル名と記述
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
