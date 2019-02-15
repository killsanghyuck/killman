module Admin
  class PostsController < Admin::ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    layout 'admin'

    # GET /posts
    # GET /posts.json
    def index
      posts = Post.all
      @posts = posts.where('user_id in (?)', current_user.id) if current_user.admin?
      @posts = posts
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
      @post = Post.find params[:id]
    end

    # GET /posts/new
    def new
      @post = Post.new
    end

    # GET /posts/1/edit
    def edit
      @post = Post.find params[:id]
    end

    # POST /postsrails generate devise:controllers [scope]
    # POST /posts.json
    def create
      @post = Post.new(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def chul_list
      chul_list = []
      for i in 1..31
        s = rand(1..98)
        hash = {:date => "2019-03-#{i < 10 ? '0' + i.to_s : i}", :time => "09:#{rand(50..59)}:#{s < 10 ? '0' + s.to_s : s}", :mode => '출근'}
        chul_list.push(hash)
        m = rand(1..20)
        s = rand(1..98)
        hash = {:date => "2019-03-#{i < 10 ? '0' + i.to_s : i}", :time => "19:#{m < 10 ? '0' + m.to_s : m}:#{s < 10 ? '0' + s.to_s : s}", :mode => '퇴근'}
        chul_list.push(hash)
      end

      @chul_lists = chul_list
      respond_to do |format|
        format.xlsx do
          render xlsx: 'chul_list', layout: false, filename: '길상혁.xlsx'
        end
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
  end
end