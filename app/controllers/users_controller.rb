class UsersController < ApplicationController
    def index
        users=User.all();
        render json: { status:'SUCCESS',message:'Loaded users',data: users }
    end
    def show
        #return "Alo"
        #render json: { status:'SUCCESS',message:'user Updated',data: 'Alo' }
        user=User.find(params[:id]);
        render json: { status:'SUCCESS',message:'Loaded user',data: @current_user }
    end
    def create
        user=User.new(user_param);
        if user.save
            render json: { status:'SUCCESS',message:'user Added',data: user }
        else
            render json: { status:'Error',message:"user Hasn't Been Added",data: user.errors }
        end
    end
    def signup
        user=User.new(user_param);
        if user.save
            render json: { status:'SUCCESS',message:'user Added',data: user }
        else
            render json: { status:'Error',message:"user Hasn't Been Added",data: user.errors }
        end
    end
    def my_posts
        the_id=@current_user.id
        the_user = User.find(the_id)
        #posts = Post.where(user_id: the_id)
        posts = the_user.posts
        render json: { status:'SUCCESS',message:'Your posts',data: posts }
    end
    def destroy
        user=User.find(params[:id]);
        user.destroy
        render json: { status:'SUCCESS',message:'user Deleted',data: user }
    end
    def logout
        @current_user =nil
        render json: { status:'SUCCESS',message:'Loged Out'}
    end
    def update
        user=User.find(params[:id]);
        #render json: { status:'SUCCESS',message:'user Updated',data: 'Alo' }
        if user.update(user_param)
            render json: { status:'SUCCESS',message:'user Updated',data: user }
        else
            render json: { status:'ERROR',message:'user Not Updated',data: user.errors }
        end
    end

    private 
    def user_param
        params.permit(:name , :email , :password , :image)
    end
end