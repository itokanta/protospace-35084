class PrototypesController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :prototype_choose, except:[:index, :new, :create,] 
  before_action :move_to_index, only:[:edit, :update, :destroy]
  # before_actionを使うと定義されたアクションを実行する前に共通の処理を行う
  # onlyやexceptなどで制約をつければ特定のアクションの実行前に処理を実行できる
  # 処理は上から順に読み込まれるので、move_to_indexの前にprototype_chooseの記述をしておかないと
  # @prototype = Prototype.find(params[:id])の記述が存在しないことになるので、move_to_indexで
  # エラーが起こる

  def index
    @prototype = Prototype.includes(:user)
    # @prototype_only = Prototype.find(1)を付け加える事でidが1のprototypeのみを表示することも可能。
    # その場合はビューファイルにも変更を加える(index.html.erb参照)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      # redirect_to root_path
      # ここのredirect_toではPrefixを使用
    else
      render :new
    end
  end

  def show
    # @prototype = Prototype.find(params[:id])←befor_actionメソッドで実行されるので本来は不要
    # findメソッドは、引数で指定したidに該当するレコードをモデルから取得してくるメソッド
    # paramsはリクエストで送信されてきた情報が格納されているハッシュのようなもの
    # したがって、params[]の形で取得する事ができる。ここでは[:id]でidを取得し、findの引数に利用している
    # 例えば...
    # @comment = Comment.new
    # @comment_only = Comment.find(15)
    # このような記述にすればidが15に該当するレコードのみを取得する事ができる(コメントを一つだけ取得できる)
    # これに合わせてビューファイルも変更すれば、取得したid15に該当するコメントのみを表示する事ができる
    @comment = Comment.new
    # @comment = Comment.newはデータを新しく保存することを意味する。ここではCommentモデルに新たに保存しますという意味
    # インスタンス変数として定義することで、該当するビューファイルに値を渡せる。ここはshowアクションを定義しているので、それに該当するprotorype/show.html.erbに渡される。
    @comments = @prototype.comments
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def prototype_choose
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless current_user == @prototype.user
      # prototype_chooseが先に実行されないと@prototypeの値が空になる
      redirect_to action: :index
    end
  end
end