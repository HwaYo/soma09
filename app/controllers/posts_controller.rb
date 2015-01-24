class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def create
  end
end
