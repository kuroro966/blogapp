class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @articles = Article.all
    @article = Article.new
  end
  
  def edit
    @article = Article.find(params[:id])
    @current_user_id = current_user.id
  end
  
  def update
    article = Article.find(params[:id])
    article.update(params_update)
    redirect_to :root
  end
  
  def params_update
    params.require(:article).permit(:text)
  end
  
  def create
    Article.create(create_params)
  end
  
  def create_params
    params.require(:article).permit(:text).merge(user_id: current_user.id)
  end
  
  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to :root
  end
  
  
end
