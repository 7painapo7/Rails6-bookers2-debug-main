class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @book_show = Book.find(params[:id])
    @book_new = Book.new
    @user = User.find(@book_show.user_id)
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    # 新着順
    if params[:sort_update] == "created_at"
      @books = Book.all.order(created_at: :DESC)
    # 評価順
    elsif params[:sort_update] == "evaluation"
      @books = Book.all.order(evaluation: :DESC)
    elsif params[:keyword]
      keyword = request.query_string.split("=")
      key = keyword[1]
      @books = Book.all.where("category = '#{key}'")
    else
      @books = Book.all
    end
    @user = current_user
    # binding.pry
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @users = User.all
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "You have destroyed book successfully."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :evaluation, :category) # 評価、カテゴリーを追加
  end
end
