class CommentsController < ApplicationController

    def update
        comment=Comment.find(params[:id]);
        if @current_user.id == comment.user_id
            if comment.update(content: params[:content])
                render json: { status:'SUCCESS',message:'Comment Updated',data: comment }
            else
                render json: { status:'ERROR',message:'Comment Not Updated',data: comment.errors }
            end
        else
            render json: { status:'Error',message:"That's Not Your Comment" }
        end
    end

    def delete
        comment=Comment.find(params[:id]);
        if @current_user.id == comment.user_id
            comment.destroy
            render json: { status:'SUCCESS',message:'Comment Deleted',data: comment }
        else
            render json: { status:'Error',message:"That's Not Your Comment" }
        end
    end

end