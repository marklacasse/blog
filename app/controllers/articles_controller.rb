class ArticlesController < ApplicationController
#setup a little security
http_basic_authenticate_with name: "guest", password: "guest", except: [:index, :show]


#ROUTE articles GET    /articles(.:format)          articles#index
  def index
    @articles = Article.all
  end

#ROUTE article GET    /articles/:id(.:format)      articles#show
  def show
    @article = Article.find(params[:id])
  end

  def new  
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params) #use article_param method to permit certain values
     
    if @article.save
      redirect_to @article
    else
      render 'new'
    end

  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end

  end

#ROUTE DELETE /articles/:id(.:format)      articles#destroy
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end


private
  #create method to only allow title and text params
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
