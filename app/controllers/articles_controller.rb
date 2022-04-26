class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :index, :destroy, :show]
  def index
    @user = current_user
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @user = current_user
    # 記事新規作成
    @article_number = Article.count + 1;
    @article = Article.new(article_params)
    # ユーザーID登録処理
    @article.user_id = @user.id
    @article.image_presence = false
    if params[:article][:image]
      @article[:image] = "article_#{@article_number}.png"
      # アップロードファイルの書き込み
      File.binwrite("public/article_images/#{@article[:image]}", params[:article][:image].read)
      @article.image = "article_#{@article_number}.png"
      @article.image_presence = true
    end
    if @article.save
        flash[:success] = '記事を作成致しました。'
        redirect_to article_path(@article.id)
    else
        flash[:danger] = '記事を作成に失敗しました'
        render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if params[:article][:image]
      @article[:image] = "article_#{@article_number}.png"
      # アップロードファイルの書き込み
      File.binwrite("public/article_images/#{@article[:image]}", params[:article][:image].read)
      @article.image = "article_#{@article_number}.png"
      @article.image_presence = true
    else
      @article.image = ""
      @article.image_presence = false
    end
    @article.title = params[:article][:title]
    @article.content = params[:article][:content]
    if @article.save
        flash[:success] = '記事を更新致しました。'
        redirect_to article_path(@article.id)
    else
        flash[:danger] = '記事の更新に失敗しました'
        render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def article_update_params
    params.require(:article).permit(:title, :content, :image)
  end
end
