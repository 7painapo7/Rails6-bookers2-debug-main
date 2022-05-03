class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method)
    elsif @model == 'book'
      @records = Book.search_for(@content, @method)
    # カテゴリー検索用
    else
      redirect_to books_path(keyword: @content)
    end
  end
end
