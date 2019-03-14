# frozen_string_literal: true

module Api
  module V1
    # Post controller
    class PostsController < Api::ApiController
      def index
        @posts = Post.all
        if @posts.present?
          render status: :ok, json: { posts: @posts }
        else
          render status: :not_found, json: { message: 'No Posts found' }
        end
      end

      def show
        @post = Post.find_by(id: params[:id])
        if @post.nil?
          render status: :not_found, json: {}
        else
          render status: :ok, json: { post: @post }
        end
      end

      def create
        @post = Post.new(post_params)
        if @post.save
          render status: :ok, json: { message: 'Successfully created the Post' }
        else
          render status: :bad_request, json: { message: 'Invalid Post' }
        end
      end

      def update
        @post = Post.find_by(id: params[:id])
        if @post
          if @post.update(post_params)
            render_success
          else
            render_failure
          end
        else
          render status: :not_found, json: { message: 'No post Found' }
        end
      end

      def render_success
        render status: :ok, json: {
          message: 'Successfully Updated the Post'
        }
      end

      def render_failure
        render status: :bad_request, json: {
          message: @post.errors.full_messages
        }
      end

      def destroy
        @post = Post.find_by(id: params[:id])
        if @post&.destroy
          render status: :ok, json: { message: 'Successfully deleted the Post' }
        else
          render status: :not_found, json: { message: 'No post Found' }
        end
      end

      private

      def post_params
        params.require(:post).permit(
          :title,
          :text,
          :image
        )
              .merge(user_id: User.first.id)
      end
    end
  end
end
