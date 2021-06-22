class AuthenticationController < ApplicationController
    # skip_before_action :authenticate_request

    # def authenticate
    #     #render json: { email: params[:email], password: params[:password] }
    # command = AuthenticateUser.call(params[:email], params[:password])

    # if command.success?
    #     render json: { auth_token: command.result }
    # else
    #     render json: { error: command.errors }, status: :unauthorized
    # end
    # end

    def login
        #render json: params[:name]
        user=User.find_by(email: params[:email]);
        if(!user)
            render json: {msg: "Invailed Email"}
        else
            if( user.authenticate(params[:password]) )
                secret_key= Rails.application.secrets.secret_key_base[0]
                #secret_key= "124"
                #token=JWT.encode(user.id,secret_key)
                token = JWT.encode user.id, secret_key
                decoded_token = JWT.decode token, secret_key, false
                render json: {msg: "Success" , token: token , decoded_token: decoded_token[0]}
            else
                render json: {msg: "Wrong Password"}
            end
        end
    end
end
