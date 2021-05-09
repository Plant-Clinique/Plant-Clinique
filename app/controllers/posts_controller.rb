require './lib/posts_utils'

class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post, only: %i[ show edit update destroy ]
  
  # GET /posts or /posts.json
  def index
    @orders = PostsUtils::ORDERS
    @all_posts = Post.all
    @current_topic = params[:search]
    @current_order = params[:order] || @orders[0]
    @all_topic_posts = Post.search(params[:search])
    @current_page_posts = PostsUtils.posts_sort(@all_topic_posts.page(params[:page]), params[:order])
    @topics = Post.topics
  end

  # GET /posts/1 or /posts/1.json
  def show
    @topics = Post.topics
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    puts @post
    respond_to do |format|
      if @post.update(post_params) and @post.edit
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    Notification.where(second_target_id: @post.id).delete_all
    Reply.where(post_id: @post.id).delete_all
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :topic, :title, :body, :create_at)
    end
end
