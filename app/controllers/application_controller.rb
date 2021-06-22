class ApplicationController < ActionController::API
    before_action :authenticate_request, except: [:login,:signup]
    #attr_reader :current_user
  
    def authenticate_request
      secret_key= Rails.application.secrets.secret_key_base[0]
      if request.headers['Authorization'].present?
        #render json: {token: request.headers['Authorization']}
        token = request.headers['Authorization']
        decoded_auth_token = JWT.decode(token, secret_key , false)
        user_id = decoded_auth_token[0]
        #puts(decoded_auth_token);
        founded_the_user = User.where(id: user_id).empty?
        #render json: {user: founded_user}
        #@current_user = founded_the_user
        if founded_the_user
          render json: { error: 'Not Authorized' }, status: 401 unless @current_user
        else
          @current_user = User.find(user_id)
        end
      else
        render json: { error: 'No Authorization Sent' }, status: 401
      end
      #render json: {token: request.headers['Authorization']}
    end
end
