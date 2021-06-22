class PostsController < ApplicationController
    def index
        posts=Post.all();
        render json: { status:'SUCCESS',message:'Loaded Posts',data: posts }
    end
    def show
        #return "Alo"
        #render json: { status:'SUCCESS',message:'Post Updated',data: 'Alo' }
        post=Post.find(params[:id]);
        render json: { status:'SUCCESS',message:'Loaded Post',data: post }
    end
    def create
        post=Post.new(post_param);
        post.user_id=@current_user.id
        if post.save
            render json: { status:'SUCCESS',message:'Post Added',data: post }
        else
            render json: { status:'Error',message:"Post Hasn't Been Added",data: post.errors }
        end
    end
    def update_tags
        post=Post.find(params[:id]);
        new_tags=params[:tags]
        if post.update(tags: new_tags)
            render json: { status:'SUCCESS',message:"Tags Updated Successfully",data: post }
        else
            render json: { status:'Error',message:"Tags Didn't Updated",data: post }
        end
    end
    def destroy
        post=Post.find(params[:id]);
        if @current_user.id == post.user_id
            post.destroy
            render json: { status:'SUCCESS',message:'Post Deleted',data: post }
        else
            render json: { status:'Error',message:"That's Not Your Post" }
        end
    end
    def comment
        post=Post.find(params[:id]);
        comment = Comment.create(post_id:post.id , user_id: @current_user.id , user_name: @current_user.name, content:params[:content])

        render json: { status:'SUCCESS',message:'Comment Added',data: post }
    end
    def all_comments
        post=Post.find(params[:id]);
        comments = post.comments
        render json: { status:'SUCCESS',message:'All Comment',data: comments }
    end
    def update
        post=Post.find(params[:id]);
        if @current_user.id == post.user_id
            if post.update(post_param)
                render json: { status:'SUCCESS',message:'Post Updated',data: post }
            else
                render json: { status:'ERROR',message:'Post Not Updated',data: post.errors }
            end
        else
            render json: { status:'Error',message:"That's Not Your Post" }
        end
    end

    private 
    def post_param
        params.permit(:title , :body ,:tags )
    end
end