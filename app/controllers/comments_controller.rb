class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to tweet_path(params[:tweet_id])  }
      format.json
    end  # コメントと結びつくツイートの詳細画面に遷移する
  end

  private
  def comment_params
    params.require(:comment).permit(:text,:tweets_id).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
