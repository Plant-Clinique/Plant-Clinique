class RepliesController < ApplicationController
  before_action :require_login
  before_action :set_reply, only: %i[ show edit update destroy ]

  # GET /replies or /replies.json
  def index
    @replies = Reply.all
  end

  # GET /replies/1 or /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies or /replies.json
  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.new(reply_params)

    respond_to do |format|
      if @reply.save
        format.html { redirect_to @post, notice: "Reply was successfully created." }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replies/1 or /replies/1.json
  def update
    @post = Post.find(reply_params[:post_id])
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @post, notice: "Reply was successfully updated." }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1 or /replies/1.json
  def destroy
    @reply.destroy
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html { redirect_to @post, notice: "Reply was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reply_params
      params.require(:reply).permit(:user_id, :post_id, :body, :created_at)
    end
end
